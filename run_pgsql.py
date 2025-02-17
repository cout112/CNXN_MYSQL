import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk

import subprocess
import os
import datetime
import time
from sqlalchemy import create_engine, text
from sqlalchemy.orm import scoped_session, sessionmaker
import paramiko
import sshtunnel

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
import plotly.graph_objects as go
from pyvis.network import Network

import webbrowser




# Constant variables

BASE_PATH = os.getcwd()
SQL_FILES_PATH = os.path.join(BASE_PATH, 'sql')
CLIENT_USER = 'root'
CLIENT_PASS = 'IH6MFN45Af'
DATABASE_NAME = 'servicedesk'
LOGS_FOLDER = os.path.join(BASE_PATH, 'logs')
REMOTE_IP = '89.140.72.212'
SERVICEDESK_BIN_PATH = '/home/ManageEngine/ServiceDesk/bin'
PGSQL_DATA_PATH = '/home/ManageEngine/ServiceDesk/pgsql/data'
PGSQL_BIN_PATH = '/home/ManageEngine/ServiceDesk/pgsql/bin'
DUMPS_PATH = os.path.join(BASE_PATH, 'DUMPS')
INJECTIONS_PATH = os.path.join(BASE_PATH, 'AUTOMATIC_INJECTIONS')
GRAPHS_PATH = os.path.join(BASE_PATH, 'GRAPHS')
INJECT_DATA_PATH = os.path.join(BASE_PATH, 'METER_DATOS')






















# -------------------------- HELPER FUNCTIONS -------------------------------
# These functions will perform repetitive tasks used in STRUCTURE FUNCTIONS
# They will be called from the structure funcions.
def main():
    def get_log():
        current_date = datetime.datetime.today().strftime('%y_%m_%d')
        file_path = os.path.join(LOGS_FOLDER, f'log_{current_date}.log')
        file = open(file_path, 'a')
        return file

    def get_config_file():
        file = open(os.path.join(BASE_PATH, 'config_values.ini'), 'r')
        return file

    def get_now():
        return datetime.datetime.now().strftime('%H:%M:%S:%f')[:-3]

    def get_date():
        return datetime.datetime.today().strftime('%Y_%m_%d')

    def log_print(message, log_message=True):
        if log_message:
            log.write(f"[{get_now()}] {message}\n")
        print(f"[{get_now()}] {message}")
        log_output.config(state='normal')
        log_output.insert('end', f"[{get_now()[:-4]}] {message}\n")
        root.update_idletasks()
        log_output.see('end')
        log_output.config(state='disabled')
        return None

    def find_list(value, check_list):
        try:
            return check_list.index(value)
        except:
            return -1

    def get_complete_database_map(complete_dump_file):
        """
        Given a complete dump sql file, create a complete maps of the database.
        """

        # Map the whole database
        complete_nodes = []
        complete_edges = []
        complete_labels = []
        tables_constraints = create_statements_list(complete_dump_file, ['CREATE TABLE', 'ALTER TABLE'])
        database_tables = dict()
        id = -1
        for statement in tables_constraints:

            # Create the tables
            if statement.startswith('CREATE TABLE'):
                id += 1
                table_name = statement.split(' (')[0].split('TABLE ')[-1]
                complete_nodes.append(id)
                complete_labels.append(table_name)

                table = dict()
                table['id'] = id
                table['name'] = table_name
                table['columns'] = [name.strip().split()[0] 
                                    for name in statement.split('\n') 
                                    if name.strip() != ');' and name.strip().split()[0].lower() == name.strip().split()[0]]
                table['foreign nodes'] = ['' for i in range(len(table['columns']))]
                table['foreign names'] = ['' for i in range(len(table['columns']))]
                table['foreign columns'] = ['' for i in range(len(table['columns']))]
                database_tables[table_name] = table
                continue

            # Add Foreign Keys
            if statement.startswith('ALTER TABLE'):

                # Get only foreign key assignments
                if statement.find('FOREIGN KEY') == -1:
                    continue

                split_statement = statement.split('\n')
                table_name = split_statement[0].split()[-1]
                constraint_line = split_statement[-1].replace(';','')
                other_table_name = constraint_line.split('(')[1].split()[-1]

                # Build list of mapped columns
                is_open = False
                columns = []
                column = ''
                for letter in constraint_line:
                    if letter == '(':
                        is_open = True
                        continue
                    if letter == ')':
                        is_open = False
                        columns.append(column)
                        column = ''
                        continue
                    if is_open:
                        column += letter
                
                current_columns = [name.strip() for name in columns[0].split(',')]
                related_columns = [name.strip() for name in columns[1].split(',')]

                # Map each column to its correspondent node and column
                for i, column_name in enumerate(current_columns):
                    index = database_tables[table_name]['columns'].index(column_name)
                    database_tables[table_name]['foreign names'][index] = other_table_name
                    database_tables[table_name]['foreign nodes'][index] = database_tables[other_table_name]['id']
                    database_tables[table_name]['foreign columns'][index] = related_columns[i]

                    complete_edges.append((database_tables[table_name]['id'], database_tables[other_table_name]['id']))

        return database_tables, complete_nodes, complete_edges, complete_labels

















# -------------------------- STRUCTURE FUNCTIONS -------------------------------
# These functions will perform structural parts of the programm. Like openning the SSH tunnel
# or interact with the centOS 7 linux machine.
# They will be called directly from the button functions.


    def check_pg_hba_files():
        """
        This checks if the client has the two versions of hb_pga files:
        - One accessible.
        - One secure.
        This is done beforehand because the upload function from paramiko put()
        is bugged and doesn't work sometimes. This is why we make an upload once
        and afterwards just move files around in the client.
        """
        command = f"ls {PGSQL_DATA_PATH}"
        log_print(f"Checking if pg_hba files exist in client.")
        try:
            stdin, stdout, stderr = client.exec_command(command)
            result = stdout.read().decode('utf-8').split('\n')
            if 'pg_hba_accessible.conf' in result and 'pg_hba_secure.conf' in result:
                log_print(f"Files already exist.")
                return None
        except Exception as e:
            log_print(f"Error trying to execute command in client. Error: {e}")
            exit(1)

        log_print(f"Files don't exist. Uploading...")
        try:
            sftp_client = client.open_sftp()
            sftp_client.put(os.path.join(os.getcwd(), 'pg_hba FILES', 'pg_hba_accessible.conf'), f'{PGSQL_DATA_PATH}/pg_hba_accessible.conf')
            sftp_client.put(os.path.join(os.getcwd(), 'pg_hba FILES', 'pg_hba_secure.conf'), f'{PGSQL_DATA_PATH}/pg_hba_secure.conf')
            sftp_client.close()
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
        log_print(f"Files uploaded in client")
        
        return None


    def connect_tunnel():
        """
        This function opens an ssh tunnel using sshtunnel library.
        Then, saves the tunnel in a global variable called tunnel.
        """
        global tunnel
        tunnel = sshtunnel.open_tunnel(
            (REMOTE_IP, 22),
            ssh_username = CLIENT_USER,
            ssh_password = CLIENT_PASS,
            remote_bind_address = ('127.0.0.1', 65432),
            local_bind_address = ('127.0.0.1', 8888)
        )
        try:
            tunnel.start()
            log_print(f"Successfully created SSH tunnel to {REMOTE_IP}")
        except Exception as e:
            log_print(f"Error trying to connected to {REMOTE_IP}. Error: {e}")
            log.close()
        return None


    def connect_client():
        """
        Once the tunnel is up and running, this function opens a client to perform
        operations throught the terminal on linux.
        """

        global client
        client = paramiko.SSHClient()
        client.load_system_host_keys()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        try:
            client.connect(hostname=REMOTE_IP, username=CLIENT_USER, password=CLIENT_PASS)
            log_print(f"Successfully connected to client with terminal access.")
        except Exception as e:
            log_print(f"Error connecting to client with terminal acces. Error: {e}")
            log.close()
        return None


    def application_secure_mode():
        """
        Turn off the ServiceDesk application running on the client server
        and shuts down database.
        Then, changes the pg_hba.conf file to accept trus on IP6 connections.
        Last, turns on database only.
        """

        # Shutdown application daemon
        command = "sudo systemctl stop servicedesk"
        log_print(f"Trying to shut down Application service.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            time.sleep(5)
            result = stdout.read().decode('utf-8').split('\n')
            for line in result:
                if len(line) == 0:
                    continue
                log_print(f"Client terminal message: {line}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
        
        # Shutdown application
        command = "sudo /home/ManageEngine/ServiceDesk/bin/shutdown.sh"
        log_print(f"Trying to shut down Application.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            time.sleep(5)
            result = stdout.read().decode('utf-8').split('\n')
            for line in result:
                if len(line) == 0:
                    continue
                log_print(f"Client terminal message: {line}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Shutdown database
        command = "sudo /home/ManageEngine/ServiceDesk/bin/stopDB.sh"
        log_print(f"Trying to shut down Database.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            result = stdout.read().decode('utf-8').split('\n')
            for line in result:
                if len(line) == 0:
                    continue
                log_print(f"Client terminal message: {line}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Wait till done
        time.sleep(2)

        # Erase pg_hba.conf file
        command = "sudo rm -R /home/ManageEngine/ServiceDesk/pgsql/data/pg_hba.conf"
        log_print(f"Erasing pg_hba.conf file in client.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            log_print(f"Remove successfully.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Change pg_hba.conf file with trust configuration
        log_print(f"Changing pg_hba file to accessible configuration.")
        command = f"sudo cp {PGSQL_DATA_PATH}/pg_hba_accessible.conf {PGSQL_DATA_PATH}/pg_hba.conf"
        try:
            client.exec_command(command)
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Check the upload was done
        command = "ls /home/ManageEngine/ServiceDesk/pgsql/data"
        stdin, stdout, sterr = client.exec_command(command)
        result = stdout.read().decode('utf-8').split()
        if 'pg_hba.conf' in result:
            log_print(f"Changed configuration successfully.")
        else:
            log_print(f"Not uploaded.")
            exit(1)

        # Turn on database only.
        command = 'sudo /home/ManageEngine/ServiceDesk/bin/startDB.sh'
        log_print(f"Starting database...")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            time.sleep(10)
            # result = stdout.read().decode('utf-8').split('\n')
            # for line in result:
            #     if len(line) == 0:
            #         continue
            #     log_print(f"Client terminal message: {line}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        log_print(f"Checking if database is open in port 65432.")
        command = 'sudo /home/ManageEngine/ServiceDesk/pgsql/bin/pg_isready -p 65432'
        try:
            stdin, stdout, sterr = client.exec_command(command)
            result = stdout.read().decode('utf-8').split('\n')
            for line in result:
                if len(line) == 0:
                    continue
                log_print(f"Client terminal message: {line}.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
            exit(1)

        return None

    def connect_to_database():
        """
        Connects to local database after tunnel is made using sqlalchemy.
        """
        engine = create_engine(f'postgresql://postgres:@:8888/{DATABASE_NAME}')
        global db
        db = scoped_session(sessionmaker(bind=engine))
        log_print(f"Trying to connect to database...")
        try:
            result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchone()
            log_print(f"Connection successful...")
        except Exception as e:
            log_print(f"Error: {e}.")

        return None


    # def close_facility_desk(log):
    #     """
    #     Checks if the application facility desk is up and running by checking the active processes of the computer.
    #     If it is running it shuts down using the application shutdown.sh bash script.
    #     """
    #     if NOT_LINUX:
    #         return None
        
    #     try:
    #         FD_FUNCIONANDO = len([  process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n')
    #                                 if 'FacilitiesDesk' in process and 'java' in process and 'run.sh' in process])
    #     except Exception as e:
    #         log_print(f'{get_now()} Command: ps, -fea -> Error: {e}\n')
    #         exit(1)
    #     if FD_FUNCIONANDO > 0:
    #         log_print(f"{get_now()} FacilitiesDesk ESTA FUNCIONANDO\n")
    #         subprocess.run(['cd', FD_SCRIPTS_PATH, '&&', './shutdown.sh', '-S'], capture_output=True, text=True)
    #         log_print(f"{get_now()} Esperando a que la aplicación se detenga...\n")
    #         CONTADOR = 0
    #         while CONTADOR < 4 and FD_FUNCIONANDO > 0:
    #             time.sleep(10)
    #             FD_FUNCIONANDO = len([  process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') 
    #                                     if 'FacilitiesDesk' in process and 'java' in process and 'run.sh' in process])
    #             CONTADOR += 1
    #         if FD_FUNCIONANDO == 1:
    #             log_print(f"{get_now()} La aplicación FacilitiesDesk no se ha podido parar\n")
    #             exit(1)
    #         else:
    #             log_print(f"{get_now()} La aplicación FacilitiesDesk se ha parado\n")
    #     return None

    # def run_no_socket_db(log):
    #     if NOT_LINUX:
    #         return None
    #     try:
    #         MYSQL_SOCKET = len([process for process in subprocess.run(["ps", "-fea"], stdout=subprocess.PIPE).stdout.decode("utf-8").split('\n') 
    #                             if 'FacilitiesDesk' in process and 'mysqld' in process.lower() and 'socket' not in process])
    #     except Exception as e:

    #         log_print(f'Command: ps, -fea -> Error: {e}\n')
    #         exit(1)
    #     if MYSQL_SOCKET > 0:
    #         print("MYSQL iniciada en modo sin Socket")
    #     else:
    #         print("Iniciando MYSQL sin Socket")
    #         subprocess.run([f"cd {FD_SCRIPTS_PATH}", "./startDB.sh_sinSocket & >/dev/null 2>&1"])
    #         time.sleep(10)
    #         try:
    #             MYSQL_SINSOCKET = len([process for process in subprocess.run(["ps", "-fea"], stdout=subprocess.PIPE).stdout.decode("utf-8") 
    #                                 if 'FacilitiesDesk' in process and 'mysqld' in process.lower() and 'socket' not in process])
    #         except Exception as e:
    #             log_print(f'Command: ps, -fea -> Error: {e}\n')

    #             exit(1)
    #         if MYSQL_SINSOCKET == 0:
    #             print("MYSQL no se ha podido arrancar sin socket")
    #             exit(1)
    #         else:
    #             print("MYSQL sin socket arrancada.")

    #     print("EJECUCION SCRIPT")


    # def run_socket_db(log):
    #     """
    #     It checks if the database is running in socket mode and shuts down using stopDB.sh bash script.
    #     """
    #     if NOT_LINUX:
    #         return None
    #     try:
    #         MYSQL_SOCKET = len([process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') if 'mysqld' in process and 'socket' in process])
    #     except Exception:
    #         log_print(f'Command: ps, -fea -> Error {Exception}\n')
    #         exit(1)
    #     if MYSQL_SOCKET > 0:
    #         log_print(f"{get_now()} Parando MYSQL en modo Socket\n")
    #         subprocess.run(['cd', FD_SCRIPTS_PATH, '&&', './stopDB.sh'], capture_output=True, text=True)
    #         CONTADOR = 0
    #         while CONTADOR < 4 and MYSQL_SOCKET > 0:
    #             time.sleep(10)
    #             MYSQL_SOCKET = len([process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') if 'mysqld' in process and 'socket' in process])
    #             CONTADOR += 1
    #         if MYSQL_SOCKET > 0:
    #             log_print(f"{get_now()} MYSQL no se ha podido parar en modo socket\n")
    #             exit(1)
    #         else:
    #             log_print(f"{get_now()} MYSQL parada.\n")

    def get_value_from_config(config_file, value):
        for line in config_file.read().split('\n'):
            if value in line:
                return line[len(value)+1:]


    def create_statements_list(dump_file, valid_statements = []):
        """
        Using the database dump, create a list of valid statements
        Args:
        dump_file: an sql file with the dump.
        valid_statements: a list of valid ways to start an statement, like CREATE TABLE. 
        """
        file_lines = dump_file.read().split('\n')

        statements = []
        useful_lines = []
        within_command = False

        all_valid = False if len(valid_statements) != 0 else True
        valid_table = False

        # Check each line on the dump file
        for line in file_lines:
            line = line.strip()

            if line.startswith('--'):
                continue
            if len(line) == 0:
                continue

            # Start new statement
            if not within_command:
                if all_valid:
                    within_command = True
                else:
                    for statement in valid_statements:
                        if line.lower().startswith(statement.lower().strip()):
                            within_command = True
            
            # Useful lines
            if within_command:
                useful_lines.append(line)

                # End command
                if  ( line.endswith(';') and not line.endswith('stdin;') ) or line.endswith('\.'):
                    statements.append(useful_lines)
                    within_command = False
                    useful_lines = []

        statements = ['\n'.join(command) for command in statements]
        return statements



    def get_database_file(prompt_message='Abrir', filename=None, initial_dir = None):
        """
        Allows the user to select one database from the previously stored dumps.
        """
        initial_dir = DUMPS_PATH if initial_dir is None else initial_dir
        database_path = None
        # Get the database to compare to
        if filename is None:
            database_path = filedialog.askopenfilename(title=prompt_message, initialdir=initial_dir)
            while database_path != "" and not database_path.endswith('.sql'):
                log_print(f"File chosen is wrong. Try one ending in .sql")
                database_path = filedialog.askopenfilename(title=prompt_message, initialdir=initial_dir)
        else:
            database_path = os.path.join(initial_dir, filename)

        database_file = open(database_path, 'r')

        return database_file

    def create_dump():
        """
        Creates a dump .sql from the current database and downloads it into
        DUMPS folder.
        """

        # Checking dumps folder exists in client
        command = 'sudo mkdir -p /home/ManageEngine/ServiceDesk/dumps'
        try:
            client.exec_command(command)
            log_print(f"Create folder dumps inside ServiceDesk folder.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")


        # Creating dump
        file_name = f'{get_date()}_1_dump.sql'
        dest_folder = f'/home/ManageEngine/ServiceDesk/dumps/{file_name}'
        command = f'sudo /home/ManageEngine/ServiceDesk/pgsql/bin/pg_dump servicedesk -U postgres -p 65432 > {dest_folder}'
        log_print(f"Trying to create new database dump.")
        try:
            stdin, stdout, stderr = client.exec_command(command)
            exit_status = stdout.channel.recv_exit_status()
            log_print(f"Created dump with current database name: {get_date()}_dump.sql")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Check if exists dump with same date in local machine.
        if file_name in os.listdir(DUMPS_PATH):
            file_name_list = file_name.split('_')
            matching_names = [name for name in os.listdir(DUMPS_PATH) if name.split('_')[:3] == file_name_list[:3]]
            matching_names.sort()
            file_num = int(matching_names[-1].split('_')[3]) + 1
            file_name = '_'.join(file_name_list[:3] + [str(file_num)] + file_name_list[4:])

        # Downloading it
        log_print(f"Downloading new database dump: {get_date()}_dump.sql...")
        try:
            sftp_client = client.open_sftp()
            sftp_client.get(dest_folder, os.path.join(DUMPS_PATH, file_name))
            sftp_client.close()
            log_print(f"Successfully downloaded on {os.path.join(DUMPS_PATH, file_name)}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
            exit(1)

        # If download success, delete dump on client machine
        command = f'sudo rm {dest_folder}'
        log_print(f"Deleting dump in client machine...")
        try:
            stdin, stdout, stderr = client.exec_command(command)
            exit_status = stdout.channel.recv_exit_status()
            log_print(f"Successfully deleted.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        log_print('Finish creating dump.')
        # dump_file = get_database_file(file_name)

        return None


    def make_database_comparison(old_database, new_database):
        """
        Compares two databases and extracts the tables which have different info
        and only returns the rows that are different.
        Args:
        old_database: a list of complete sql statements to get info in the database 
        from the dump.
        new_database: a list of complete sql statements to get info in the database
        from the dump.
        """

        # Extract old tables names
        old_tables = [line.split()[1] for line in old_database]

        changed = []
        for i, new_statement in enumerate(new_database):

            # Check only statements that are not equal in both dumps
            if new_statement not in old_database:

                data_table = []
                new_statement_lines = new_statement.split('\n')

                # Check if table is new
                new_table_name = new_statement.split()[1]
                old_tables_index = find_list(new_table_name, old_tables)

                # New table
                if old_tables_index == -1:

                    # Log results
                    log_print(f"New table detected: {new_table_name}")
                    data_table.append(new_table_name)
                    for ii, line in enumerate(new_statement_lines):

                        # If first line of statement
                        if ii == 0:
                            columns = [name.strip() for name in line.split("(")[1].split(')')[0].split(',')]
                            data_table.append(columns)
                            continue

                        # If line is empty
                        if ii == len(new_statement.split('\n')) - 1:
                            continue

                        # If line is data
                        data = line.split('\t')
                        data_table.append(data)

                    continue


                # If table exists, create table with only new info
                old_database_lines = old_database[old_tables_index].split('\n')

                # Log results
                log_print(f"Existing table changed: {new_table_name} with: {len(old_database_lines)} lines")

                for ii, line in enumerate(new_statement_lines):

                    # Create columns
                    if ii == 0:
                        data_table.append(new_table_name)
                        columns = [name.strip() for name in line.split("(")[1].split(')')[0].split(',')]
                        data_table.append(columns)
                        continue
                    if ii == len(new_statement.split('\n')) - 1:
                        continue

                    # Add new lines
                    if line not in old_database_lines:
                        data = line.split('\t')
                        data_table.append(data)

                # Append table to changed
                changed.append(data_table)
                # print(data_table) 

        return changed


    def create_nodes_edges(complete_dump_file, sql_file):
        """
        Turns a sql file of insert statements into a nodes and edges list.
        It downloads all the columns of the tables affected to see the edge direction.
         Args:
         complete_dump_file: a sql dump file from database, to extract Forein Keys (edges)
         sql_file: file with the INSERT INTO statements
        """

        # Mapt the whole database
        database_tables, complete_nodes, complete_edges, complete_labels = get_complete_database_map(complete_dump_file)


        # Create subset of nodes and edges from changed tables
        injection_text = sql_file.read()
        injection_lines = injection_text.split('\n')

        changed_nodes = []
        affected_nodes = []
        directly_affected_edges = set()
        indirectly_affected_edges = set()
        changed_labels = []
        affected_labels = []
        

        for line in injection_lines:
            line = line.strip()

            # Remove invalid lines
            if len(line) == 0:
                continue

            # Add nodes
            table_name = line.split('(')[0].split()[-1]
            changed_nodes.append(database_tables[table_name]['id'])
            connected_columns = [
                                    f"-{database_tables[table_name]['foreign names'][i]}: {database_tables[table_name]['foreign columns'][i]} > {database_tables[table_name]['columns'][i]}"
                                    for i, node_num in enumerate(database_tables[table_name]['foreign nodes'])
                                    if node_num != ""
                                ]
            table_label = 'TABLE: ' + table_name + '\n' + '\n'.join(connected_columns)
            changed_labels.append(table_label)

        for edge in complete_edges:
            x, y = edge
            if x in changed_nodes and y in changed_nodes:
                directly_affected_edges.add(edge)
                continue
            if x in changed_nodes:
                indirectly_affected_edges.add(edge)
                affected_nodes.append(y)
                y_name = list(database_tables.keys())[y]
                connected_columns = [   f"-{database_tables[y_name]['foreign names'][i]}: {database_tables[y_name]['foreign columns'][i]} > {database_tables[y_name]['columns'][i]}" 
                                        for i, node_num in enumerate(database_tables[y_name]['foreign nodes']) 
                                        if node_num == x
                                    ]
                y_label = 'TABLE: ' + y_name + '\n' + '\n'.join(connected_columns)
                affected_labels.append(y_label)
                continue
            if y in changed_nodes:
                indirectly_affected_edges.add(edge)
                affected_nodes.append(x)
                x_name = list(database_tables.keys())[x]
                y_name = list(database_tables.keys())[y]
                connected_columns = [   f"-{database_tables[x_name]['foreign names'][i]}: {database_tables[x_name]['foreign columns'][i]} > {database_tables[x_name]['columns'][i]}" 
                                        for i, node_num in enumerate(database_tables[x_name]['foreign nodes']) 
                                        if node_num == y
                                    ]
                x_label = 'TABLE: ' + x_name + '\n' + '\n'.join(connected_columns)
                affected_labels.append(x_label)
        
        return changed_labels, affected_labels, changed_nodes, affected_nodes, directly_affected_edges, indirectly_affected_edges

          

    def shutdown_database():
        """
        Shuts down database.
        """
        command = "sudo /home/ManageEngine/ServiceDesk/bin/stopDB.sh"
        log_print(f"Trying to shut down Database.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            exit_status = stdout.channel.recv_exit_status()
            result = stdout.read().decode('utf-8').split('\n')
            for line in result:
                if len(line) == 0:
                    continue
                log_print(f"Client terminal message: {line}")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
        return None

    def secure_database_config_files():
        """
        Make database secure again by changing pg_hba.conf back to secure configuration.
        """
        # Erase pg_hba.conf file
        command = "sudo rm -R /home/ManageEngine/ServiceDesk/pgsql/data/pg_hba.conf"
        log_print(f"Erasing pg_hba.conf file in client.")
        try:
            stdin, stdout, sterr = client.exec_command(command)
            log_print(f"Remove successfully.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Change pg_hba.conf file with secure configuration
        log_print(f"Changing pg_hba file to secure.")
        command = f"sudo cp {PGSQL_DATA_PATH}/pg_hba_secure.conf {PGSQL_DATA_PATH}/pg_hba.conf"
        try:
            client.exec_command(command)
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Check the upload was done
        command = "ls /home/ManageEngine/ServiceDesk/pgsql/data"
        stdin, stdout, sterr = client.exec_command(command)
        result = stdout.read().decode('utf-8').split()
        if 'pg_hba.conf' in result:
            log_print(f"Changed configuration successfully.")
        else:
            log_print(f"Not uploaded.")
            exit(1)
        return None

    def restart_servicedesk():
        """
        Restarts the application service to make available to the outside.
        """
        # Run application
        command = "sudo systemctl start servicedesk"
        log_print(f"Trying to start application...")
        try:
            client.exec_command(command)
            log_print(f"Application started succesfully. It will take a few minutes to be completely deployed.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")
        return None

    def trim_sql_text(text):
        """
        From a sql text we get the column names and select only the connected bits of it.
        Then, it selects the largest connected group and saves it.
        Then, returns a trimmed version of the sql file with only selected tables.
        """

        # Right now this is done manually

        return ''

    def extract_tables(base_sql_file):
        """
        From a sql file of insert statements, return list of tables.
        """
        text = base_sql_file.read()
        lines = text.split('\n')
        return list({line.split("(")[0].split()[-1] for line in lines})

    def define_order(tables, labels, nodes, edges):
        """
        From a list of tables, use the nodes and edges to find the ordered tree.
        Keep in mind that the edges are directional, but are saved in opposite
        direction.
        """
        used_nodes = [node for i, node in enumerate(nodes) if labels[i] in tables]
        used_edges = [edge for edge in edges if edge[0] in used_nodes and edge[1] in used_nodes]
        
        parent_nodes = list()
        # We need to find all tables that have no parent
        for y, x in used_edges:
            if x in parent_nodes:
                continue
            is_parent = True
            for yy, xx in used_edges:
                # If node has a parent
                if x == y:
                    is_parent = False
                    break
            if is_parent:
                parent_nodes.append(x)

        # Once we have all the parents, we must go down the tree, using BFS algorithm
        # And a FIFO pool selection method. We will use the parent_nodes list as pool.
        visited_nodes = list()
        while len(parent_nodes) > 0:
            node = parent_nodes.pop(0)
            visited_nodes.append(node)
            for y, x in used_edges:
                if x == node:
                    if y not in visited_nodes and y not in parent_nodes:
                        # Check if there are other parent nodes not visited
                        all_parents_visited = True
                        for yy, xx in used_edges:
                            if y != yy:
                                continue
                            if xx == node:
                                continue
                            if xx not in parent_nodes and xx not in visited_nodes:
                                # There exists a parent node not yet visited
                                all_parents_visited = False
                                break
                        
                        if all_parents_visited:
                            parent_nodes.append(y)

        # Create ordered labels list from visited_nodes
        ordered_tables = [labels[nodes.index(node)] for node in visited_nodes]

        print(f"Ordered nodes: {ordered_tables}")
        
        return ordered_tables


    def get_used_tree(ordered_tables, tree):
        """
        Extracts a subtree with only used tables
        """
        return {table: tree[table] for table in ordered_tables}
        

    def get_data_from_excel(file_path):
        """
        Returns a dataframe given a file_path
        """
        data_frame = pd.read_excel(file_path, dtype={'PLANTA': 'string'})
        return data_frame


    def get_rules(injection = 'SPACES'):
        """
        This is the place to define the rules that the program has to 
        follow in order to make the injection and combine with the .xlsx file
        """
        injections = ['SPACES']
        if injection not in injections:
            log_print(f'{injection} not accepted as valid injection type. Try {injections}')
            return None
        
        if injection == 'SPACES':
            # Spaces injection detected.
            
            rules = """
            For each line of the excel file, we need to detect which kind of space it is.
            We can find: Campus, Building, Non Building, Floor, Room, Room Partition, Facility Service
            For each new space created, it needs to add a connection in the public.spaceparent table.
            If the space parent is not created (ie, Creating a room in a floor not yet defined)
            we are going to create, programatically, the floor first.
            custommoduleinstancespace: 
            """


        return rules

    def create_inserts(data_introduced, used_tree, rules):
        """
        Going each row in the excel, create ordered INSERT INTO statements
        to introduce data in the database
        """

        # Detect type of space
        data_introduced['TYPE'] = np.where( ~data_introduced['ESTANCIA'].isnull(),
                                            'ESTANCIA',
                                            np.where(   
                                                ~data_introduced['PLANTA'].isnull(),
                                                'PLANTA',
                                                np.where(
                                                    ~data_introduced['ESPACIO'].isnull(),
                                                    'ESPACIO',
                                                    np.where(   
                                                        ~data_introduced['EDIFICIO'].isnull(),
                                                        'EDIFICIO',
                                                        np.where(
                                                            ~data_introduced['CAMPUS'].isnull(),
                                                            'CAMPUS',
                                                            'LUGAR')))))

        data_length = data_introduced.shape[0]

        module_id_options = [   ('LUGAR','Spaces',100000037, 100000001),
                                ('CAMPUS','Campuses',100000038, 100000003),
                                ('EDIFICIO','Buildings',100000040, 100000004),
                                ('ESPACIO','Nonbuildings',100000041, 100000005),
                                ('PLANTA','Floors',100000042, 100000006),
                                ('ESTANCIA','Rooms',100000043, 100000007)]

        current_timestamp = int(datetime.datetime.now().timestamp())
        
        # For each new data introduced
        for i in range(data_length-9):
            data_type = data_introduced.iloc[i]['TYPE'][0]


            # Get existing data
            result = db.execute("SELECT * FROM public.custommoduleinstancespace;")
            existing_data = pd.DataFrame(result.fetchall(), columns=result.keys())
            insert_statements = []
            last_id = existing_data['custommoduleinstanceid'].max()


            # Detect how many rows it does have to add
            connected_previous_id = (None, None)
            id_connections = []
            for module in module_id_options:
                
                # Find existing module
                data = data_introduced.iloc[i][module[0]]
                space_type_code = module[2]
                space_type_default_code = module[3]

                
                # Skip if type of structure not met
                if module[0] == 'EDIFICIO' and data_type == 'ESPACIO':
                    continue
                if module[0] == 'ESPACIO' and data_type != 'ESPACIO':
                    continue
                if module[0] == 'LUGAR':
                    continue

                # Check if exists
                matching_data = existing_data[ (existing_data['moduleid'] == space_type_code) & (existing_data['instance_name'] == data) ]
                if matching_data.shape[0] == 0:

                    # If it doesn't create the space
                    last_id += 1
                    id_connections.append((connected_previous_id, (last_id, module[0])))
                    insert = {
                    'custommoduleinstanceid': last_id,
                    'moduleid': space_type_code,
                    'templateid': space_type_default_code,
                    'instance_name': data,
                    'description': data_introduced.iloc[i]['DESCRIPCIÓN'][0] if data_type == module[0] else 'NULL',
                    'created_time': current_timestamp,
                    'created_by': 5,
                    'last_modified_time': 'NULL',
                    'last_modified_by': 'NULL',
                    'alias': str(data).replace(' ','_').lower(),
                    'space_area': data_introduced.iloc[i]['AREA'][0] if data_type == module[0] else 'NULL',
                    'total_capacity': 'NULL',
                    'occupied_capacity': 'NULL',
                    'available_capacity': 'NULL',
                    'statusid': 100000001,
                    'supervisor': 'NULL',
                    'display_image': 'NULL',
                    'spaceunit': 100000001,
                    'building_type': 'Floors and Rooms' if module[0] == 'EDIFICIO' else 'NULL',
                    'structure_type': 'space_building' if module[0] == 'EDIFICIO' else 'NULL',
                    'is_room_partitionable': 'f' if module[0] == 'ESTANCIA' else 'NULL',
                    'is_floating_capacity': 't' if module[0] == 'ESTANCIA' else 'NULL',
                    'partition_capacity': 'NULL',
                    'department': 'NULL',
                    'helpdeskid': 301
                    }
                    insert_statement = 'INSERT INTO public.custommoduleinstancespace('
                    for key, value in insert.items():
                        insert_statement += key + ','
                    insert_statement += ') VALUES('
                    for key, value in insert.items():
                        if isinstance(value, str):
                            if value == 'NULL':
                                insert_statement += value + ','
                            else:
                                insert_statement += "'" + value + "'" + ','
                        else:
                            insert_statement += str(value) + ','
                    insert_statement += ');'
                    insert_statement = insert_statement.replace(',)', ')')

                    insert_statements.append(insert_statement)
                    connected_previous_id = (last_id, module[0])

                    # Map the space with a supervisor
                    insert_statement = f'INSERT INTO public.spacetosupervisormapping(spaceid, supervisorid) VALUES({last_id}, 5);'
                    insert_statements.append(insert_statement)

                    # Get the connnections for the space
                    is_there_parent = True
                    connection_stream = [(last_id, module[0])]
                    check_id = last_id
                    while is_there_parent:
                        found = False
                        for parent, child in id_connections:
                            
                            if child[0] == check_id:
                                found = True
                                check_id = parent[0]
                                if parent[0] == None:
                                    continue
                                connection_stream.insert(0, parent)
                        if not found:
                            is_there_parent = False
                    
                    # Create the spacetoparent inserts
                    insert_statement = f'INSERT INTO public.spaceparent(spaceid,siteid,campusid,structureid,floorid,roomid) VALUES({connection_stream[-1][0]}'
                    siteid = 'NULL'
                    campusid = 'NULL'
                    structureid = 'NULL'
                    floorid = 'NULL'
                    roomid = 'NULL'
                    if len(connection_stream) > 1:
                        for level in connection_stream:
                            if level[0] == connection_stream[-1][0]:
                                continue
                            if level[1] == 'LUGAR':
                                siteid = level[0]
                                continue
                            if level[1] == 'CAMPUS':
                                campusid = level[0]
                                continue
                            if level[1] == 'EDIFICIO':
                                structureid = level[0]
                                continue
                            if level[1] == 'PLANTA':
                                floorid = level[0]
                                continue
                            if level[1] == 'ESTANCIA':
                                roomid = level[0]
                                continue
                    insert_statement += f", {siteid}, {campusid}, {structureid}, {floorid}, {roomid});"
                    insert_statements.append(insert_statement)

                else:
                    # If it does exist, just keep track of id
                    current_id = matching_data['custommoduleinstanceid'].iloc[0]
                    current_type = matching_data['moduleid'].iloc[0]
                    for spanish_name, english_name, space_type_id, default_type_id in module_id_options:
                        if space_type_id == current_type:
                            current_space_type = spanish_name
                            break
                    # id_connections.append(((current_id, current_space_type), connected_previous_id))
                    connected_previous_id = (current_id, current_space_type)

                # Do not keep looking after space type reached
                if module == data_type:
                    break

        return insert_statements


    def execute_inserts(inserts, ordered_tables):
        """
        Executes the insert statements in the database in order
        """
        # Divide inserts by table
        ordered_insert_lists = [[] for table in ordered_tables]
        for insert in inserts:
            table_name = insert.split('(')[0].split()[-1]
            ordered_insert_lists[ordered_tables.index(table_name)].append(insert)

        for insert_type in ordered_insert_lists:
            for insert in insert_type:
                db.execute(insert)
            db.commit()

        return None
             




            
















# -------------------------- GUI FUNCTIONS -------------------------------
# These functions are componed by a series of instructions defined in the structure 
# functions. They are the functions called by the buttons on the GUI, and they will
# use the structure functions to perform tasks.
# They also change thins in the GUI.

    def connect_to_client():
        """
        Creates a tunnel to the client machine, shutsdown application and opens database
        in secure mode, then accesses database and enables execute queries button.
        """    
        global log
        log = get_log()
        
        log_print("STARTING PROGRAM: NO ERRORS FOUND.")
        connect_tunnel()
        connect_client()
        check_pg_hba_files()
        application_secure_mode()
        connect_to_database()

        # config_file = get_config_file()   
        # closed_state_id = get_value_from_config(config_file, 'ESTADO_CERRADO')
        # mp_id = get_value_from_config(config_file, 'MP')



        # Perform changes in the GUI
        # safe_connect_button.config(state='disabled')
        execute_sql_button.config(state="normal")
        text_input.config(state='normal')
        option2.config(state='normal')
        compare_db_button.config(state='normal')
        disconnect_securely_button.config(state='normal')
        create_dump_button.config(state='normal')
        create_graph_button.config(state='normal')
        add_spaces_button.config(state='normal')
        disconnect_button.config(state='normal')

        return None

    def already_connected():
        global log
        log = get_log()

        log_print("STARTING PROGRAM: NO ERRORS FOUND.")
        connect_tunnel()
        connect_client()
        connect_to_database()

        # Perform changes in the GUI
        # safe_connect_button.config(state='disabled')
        execute_sql_button.config(state="normal")
        text_input.config(state='normal')
        option2.config(state='normal')
        compare_db_button.config(state='normal')
        disconnect_securely_button.config(state='normal')
        create_dump_button.config(state='normal')
        create_graph_button.config(state='normal')
        add_spaces_button.config(state='normal')
        disconnect_button.config(state='normal')

        return None

    #def connect_database():
        #Connect to database
        # engine=create_engine(f'mysql+mysqlconnector://{MYSQL_USER}@{MYSQL_SERVER}/{MYSQL_DATABASE}')
        
        # connection = engine.connect()
        # log = get_log()
        # global db
        # try:
        #     engine=create_engine('mysql+mysqlconnector://root:Adrive_50!mysql@localhost/facilitydeskdb')
        #     db = scoped_session(sessionmaker(bind=engine))
        # except Exception as e:
        #     log_print(f"{get_now()} Connection to database error: {e}")

        # client = paramiko.SSHClient()
        # client.load_system_host_keys()
        # client.load_host_keys(os.path.expanduser(''))
        # client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # client.connect(hostname='89.140.72.212', username='root', password='IH6MFN45Af')
        

        #OPT1 do not connect a sqlalchemy connection
        # client.exec_command('cd /home/ManageEngine/ServiceDesk/bin')
        # stdin, stdout, stderr = client.exec_command('ls -lah')
        # print(stdout.read().decode('utf-8'))

        # client.exec_command('sudo /home/ManageEngine/ServiceDesk/pgsql/bin/psql -h localhost -U postgres -p 65432')
        # client.exec_command('\c servicedesk')
        # stdin, stdout, stderr = client.exec_command('\dt')
        # print(stdout.read().decode('utf-8'))

        # channel = client.invoke_shell()
        # stdin = channel.makefile('wb')
        # stdout = channel.makefile('rb')
        
        # stdin.write('''
        # sudo /home/ManageEngine/ServiceDesk/pgsql/bin/psql -h localhost -U postgres -p 65432
        # \c servicedesk
        # \dt
        # \q
        # exit
        # ''')

        # result = stdout.read().decode('utf-8').split('\n')
        # for line in result:
        #     print(line)
        # stdout.close()
        # stdin.close()

        #OPT2 connect slqalchymy
        # Open the SSH Transport
        # transport = paramiko.Transport(('89.140.72.212', 22))
        # transport.connect(username='root', password='IH6MFN45Af')
        # transport = paramiko.Transport(('192.168.1.56', 22))
        # transport.connect(username='cout112', password='1234')
        
        # # Create the tunnel
        # remote_bind_address = ('localhost', 65432)
        # local_bind_address = ('192.168.1.56', 65432)
        # tunnel = transport.open_channel('direct-tcpip', remote_bind_address, local_bind_address)

        # # Create the engine
        # engine = create_engine(f"postgresql://localhost:65432/{DATABASE_NAME}")
        # # db = scoped_session(sessionmaker(bind=engine))
        # connection = engine.connect()
        

        # # Make the database call
        # result = connection.execute(text("SELECT table_name FROM information_schema.tables WHERE table_schema='public'"))
        # for row in result:
        #     print(row[0])
        # # result = db.execute('\l').fetchall()
        # # print(result)
        # # db.commit()


        # # Close the tunnel
        # tunnel.close()

        # client.close()




        # --------------
        # CONNECT TO LINUX USING SSH AND RUNNING MULTIPLE COMMANDS CONCATENATED. IT DOES NOT WORK TO ACCESS DATABASE
        # ssh_client = paramiko.SSHClient()
        # ssh_client.load_system_host_keys()
        # ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        # ssh_client.connect(hostname='89.140.72.212', username='root', password='IH6MFN45Af')
        
        # commands = ["""
        #             whoami
        #             cd /home/ManageEngine/ServiceDesk/pgsql/bin/psql
        #             pwd
        #             sudo /home/ManageEngine/ServiceDesk/pgsql/bin/psql -U postgres -p 65432
        #             \c servicedesk
        #             SELECT table_name FROM information_schema.tables WHERE table_schema='public';
        #             ^C
        #             """]
        # commands = ["""
        #             whoami
        #             cd /home/ManageEngine/ServiceDesk/pgsql/bin
        #             pwd
        #             ls -lah
        #             """]

        # for command in commands:
        #     stdin, stdout, sterr = ssh_client.exec_command(command)
        #     time.sleep(1)
        #     result = stdout.read().decode('utf-8').split('\n')
        #     for line in result:
        #         print(f"Result: {line}")


        # commands = ["""
        #             sudo /home/ManageEngine/ServiceDesk/pgsql/bin/psql -U postgres -p 65432 servicedesk
        #             SELECT table_name FROM information_schema.tables WHERE table_schema='public';
        #             \q
        #             """]
        # for command in commands:
        #     stdin, stdout, sterr = ssh_client.exec_command(command)
        #     time.sleep(1)
        #     result = stdout.read().decode('utf-8').split('\n')
        #     for line in result:
        #         print(f"Result: {line}")

        # ssh_client.close()
        # --------------


        # --------------
        # CONNECT TO DATABASE DIRECTLY BY USING ITS IP ADDRESS AND PORT WITH SQLALCHEMY
        # engine = create_engine(f'postgresql://postgres@89.140.72.212:65432/{DATABASE_NAME}')
        # db = scoped_session(sessionmaker(bind=engine))
        # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
        # print(result)
        # --------------



        # --------------
        # CONNECT TO DATABASE USING A SSH TUNNEL AND SQLALCHEMY
        # server =    SSHTunnelForwarder(
        #         ('89.140.72.212', 22),
        #         ssh_username = 'root',
        #         ssh_password = 'IH6MFN45Af',
        #         remote_bind_address = ('127.0.0.1', 65432)
        # )
        # server.start()
        # local_port = server.local_bind_port


        # engine = create_engine(f'postgresql://postgres@:65432/{DATABASE_NAME}')
        # db = scoped_session(sessionmaker(bind=engine))
        # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()

        # print(result)
        # --------------


        # --------------
        # CREATE A TUNNEL USING SSHTUNNERFORWARDER AND EXECUTE COMMANDS INSIDE LINUX
        # global server
        # server =    SSHTunnelForwarder(
        #         ('89.140.72.212', 22),
        #         ssh_username = 'root',
        #         ssh_password = 'IH6MFN45Af',
        #         remote_bind_address = ('127.0.0.1', 65432)
        # )
        # server.start()
        # local_port = server.local_bind_port
        # print(local_port)
        # --------------
        


        # -------------- WORKS
        # OPEN A SUSTAINED TUNNEL THROUGH THE CMD PROMT LINE WITH THE NEXT COMMAND 
        # ssh -N -L localhost:8888:localhost:65432 root@89.140.72.212
        # ssh -N -L 8888:localhost:65432 root@89.140.72.212
        # This makes an openning and binds together local 8888 port to localhost:65432 on remote computer.
        # engine = create_engine(f'postgresql://postgres:@:8888/{DATABASE_NAME}')
        # db = scoped_session(sessionmaker(bind=engine))
        # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
        # for table in result:
        #     print(table[0])
        # --------------


        # -------------- WORKS
        # OPEN A TUNNEL WITH PYTHON CHANGING THE IP CONNECTED AND ACCESSING USING SQLALCHEMY
        # The key is to open the ssh tunnel using the with statement, and putting the sqlalchemy inside.
        # with open_tunnel(
        #     ('89.140.72.212', 22),
        #     ssh_username = 'root',
        #     ssh_password = 'IH6MFN45Af',
        #     remote_bind_address = ('127.0.0.1', 65432),
        #     local_bind_address = ('127.0.0.1', 8888)
        # ) as server:
        #     engine = create_engine(f'postgresql://postgres:@:8888/{DATABASE_NAME}')
        #     db = scoped_session(sessionmaker(bind=engine))
        #     result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
        #     for table in result:
        #         table_columns = db.execute(f"SELECT * from information_schema.columns where table_schema = 'schema_name' and table_name = '{table[0]}'").fetchall()
        #         print(f"{table}: {table_columns}")
        # --------------


        # -------------- WORKS
        # OPEN A TUNNEL WITH PYTHON CHANGING THE IP CONNECTED AND ACCESSING USING SQLALCHEMY
        # The key is to open the ssh tunnel using the with statement, and putting the sqlalchemy inside.
        # tunnel = sshtunnel.open_tunnel(
        #     ('89.140.72.212', 22),
        #     ssh_username = 'root',
        #     ssh_password = 'IH6MFN45Af',
        #     remote_bind_address = ('127.0.0.1', 65432),
        #     local_bind_address = ('127.0.0.1', 8888)
        # )
        # tunnel.start()
        # engine = create_engine(f'postgresql://postgres:@:8888/{DATABASE_NAME}')
        # db = scoped_session(sessionmaker(bind=engine))
        # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
        # for i, table in enumerate(result):
        #     table_columns = db.execute(f"SELECT * from information_schema.columns where table_schema = 'schema_name' and table_name = '{table[0]}'").fetchall()
        #     print(f"{table[0]}: {table_columns}")
        #     if i > 20:
        #         break
        # tunnel.stop()
        # --------------



        # --------------
        # transport = ssh_client.get_transport()
        # local_bind_address = ('127.0.0.1', 65432)
        # remote_bind_address = ('127.0.0.1', 65432)
        # transport.request_port_forward('127.0.0.1',65432)
        # --------------


        # engine = create_engine(f"postgresql://localhost:65432/{DATABASE_NAME}")
        # db = scoped_session(sessionmaker(bind=engine))

        # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
        # for line in result:
        #     print(result)




        # connection = psycopg2.connect(port=65432, user='postgres', dbname=DATABASE_NAME)

        # cursor = connection.cursor()

        # cursor.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""")

        # tables = cursor.fetchall()

        # for table in tables:
        #     print(table[0])

        # cursor.close()
        # connection.close()

        #Enable rest of buttons if connection is succesful
        # execute_sql_button.config(state='disabled')
        # text_input.config(state='normal')

        # subprocess.call(["./script2.sh", filepath])
        # pass



    def execute_code():
        """
        This function allows to execute code directly into the database.
        This is a very risky operation to do, so do it carefully.
        """
        # Get the text from the box
        text = text_input.get('1.0', 'end-1c')
        text_input.delete('1.0', 'end')
        
        if text.strip().split()[0].lower() != 'select':
            log_print(f"Execute query: {text}")
            log_print(f"QUERY: {text} not allowed. Use SELECT statement instead")
            return None

        # Execute the code in the database
        log_print(f"Execute query: {text}")
        text = text if text[-1] == ";" else f"{text};"
        result = db.execute(text)

        # Print results
        result_list = result.fetchall()
        columns = list(result.keys())
        log_print(f"Columns: {columns}", False)
        for line in result_list[:20]:
            log_print(line, False)

        if len(result_list) > 20:
            log_print('...', False)
            log_print('...', False)
            log_print('...', False)

        # If 'Save' selected, save csv with file
        if save_data.get() == 'Save':    
            df = pd.DataFrame(result_list, columns=columns)
            df.to_csv(os.path.join(BASE_PATH, 'tables.csv'))

        return None

    def compare_databases():
        """
        Creates a dump of the current database and stores it locally.
        """

        # Get the files to compare
        old_database_file = get_database_file('Antigua')
        new_database_file = get_database_file('Nueva')

        # Create comparable data structures
        old_statements = create_statements_list(old_database_file, ['COPY'])
        new_statements = create_statements_list(new_database_file, ['COPY'])



        print(f"Old Stamements: {len(old_statements)}")
        print(f"New Stamements: {len(new_statements)}")

        # Make comparison
        changed = make_database_comparison(old_statements, new_statements)

        # # Print new data
        # for i, statement in enumerate(changed):
        #     log_print(f"TABLE: {i+1}", False)
        #     for line in statement:
        #         log_print(line, False)

        log_print(f"Changed {len(changed)} tables", False)

        # Save tables to sql statements
        text = ''
        for table in changed:
            for i in range(2, len(table)):
                text += f"INSERT INTO {table[0]}({','.join(table[1])}) VALUES({','.join(table[i])});\n"

        existing_names = os.listdir(INJECTIONS_PATH)
        number = 1
        for name in existing_names:
            if name.split('_')[:3] == get_date().split('_'):
                number = str(int(name.split('_')[3]) + 1)

        name = f"{get_date()}_{number}_complete.sql"
        log_print(f"File with extracted new info saved in: {os.path.join(INJECTIONS_PATH, name)}")
        sql_file = open(os.path.join(INJECTIONS_PATH, name), 'w')
        sql_file.write(text)
        sql_file.close()

        trimmed_text =  trim_sql_text(text)

        name = f"{get_date()}_{number}_trimmed.sql"
        sql_file = open(os.path.join(INJECTIONS_PATH, name), 'w')
        sql_file.write(trimmed_text)
        sql_file.close()

        # sql_file = filedialog.asksaveasfile(title='SAVE SQL', initialdir=INJECTIONS_PATH)
        # sql_file.write(text)
        # sql_file.close()
        return None


    def disconnect_securely_client():
        """
        Disconnect from the client and restore security.
        """

        # Shutdown database
        shutdown_database()
        # time.sleep(5)

        # Make database secure again changing pg_hba.conf files
        secure_database_config_files()
        restart_servicedesk()        

        # Once everything is done, close all connections and end the program.
        client.close()
        tunnel.close()
        log_print(f"Successfully closed connection.")
        exit(0)
        return None

    def disconnect_client():
        """
        Disconnects from the database and closes the SSH tunnel but
        it won't change database security to be accessible from the outside
        and it won't start the application service again.
        """
        # shutdown_database()
        # time.sleep(5)
        client.close()
        tunnel.close()
        log_print(f"Closed connection without securing it.")
        exit(0)
        return None


    def download_dump():
        create_dump()
        return None

    def create_graph():
        """
        Selects a file inthe INECTIONS PATH folder and creates a graph to visualize it.
        """
        # Get file
        injection_file = get_database_file('Select sql injection', initial_dir=INJECTIONS_PATH)
        if injection_file == '':
            log_print(f'Exit Create Graph function')
            exit(0)
        complete_dump_file = get_database_file('FROM DUMP', initial_dir=DUMPS_PATH)
        if complete_dump_file == '':
            log_print(f'Exit Create Graph function')
            exit(0)


        # Create nodes and edges
        log_print(f"Creating a list of nodes and edges")
        changed_labels, affected_labels, changed_nodes, affected_nodes, directly_affected_edges, indirectly_affected_edges = create_nodes_edges(complete_dump_file, injection_file)

        # Plot OPT3
        log_print(f'Representing graph...')
        G = Network(directed = True,
                    notebook=True, 
                    cdn_resources='remote',
                    bgcolor='#222222',
                    font_color='white',
                    height=740)
        G.repulsion(node_distance=400, spring_length=700)


        # Add changed and affected nodes and labels
        for i in range(len(changed_nodes)):
            G.add_node(changed_nodes[i], label=changed_labels[i], color='#FD964B', size=30, mass=7, level=1)
        for i in range(len(affected_nodes)):
            G.add_node(affected_nodes[i], label=affected_labels[i], color='#6B4F3B', size=10, mass=2, level=2)

        # Add directly and indirectly affected edges
        for x, y in directly_affected_edges:
            G.add_edge(y, x, color='#FD964B', width=8, level=1)
        for x, y in indirectly_affected_edges:
            G.add_edge(y, x, color='#6B4F3B', width=2, level=2)

        G.show_buttons(filter_=['physics'])
        path_to_graph = os.path.join( GRAPHS_PATH, os.path.basename(complete_dump_file.name) )[:-3] + 'html'
        G.show( path_to_graph )
        webbrowser.open(path_to_graph)


        return None
        

    def add_spaces():
        """
        Selects an excel file with spaces data to upload to dabase.
        """

        # Get file 
        base_sql_file = get_database_file(filename='METER_ESPACIO.sql', initial_dir=INJECT_DATA_PATH)
        complete_dump_file = get_database_file(filename='5_2023_01_26_creado_espacio.sql', initial_dir=DUMPS_PATH)

        # Create tree
        log_print(f"Creating a list of nodes and edges")
        tree, nodes, edges, labels = get_complete_database_map(complete_dump_file)
        tables = extract_tables(base_sql_file)
        print(f" Tables: {tables}")

        ordered_tables = define_order(tables, labels, nodes, edges)
        used_tree = get_used_tree(ordered_tables, tree)
        rules = get_rules('SPACES')
        data = get_data_from_excel(os.path.join(INJECT_DATA_PATH, 'Nuevos Espacios.xlsx'))
        inserts = create_inserts(data, used_tree, rules)
        for insert in inserts:
            print(insert)
        execute_inserts(inserts, ordered_tables)

        return None

        






        

    
    # Create the window
    root = tk.Tk()
    root.geometry("490x620") # set the size of the main window
    root.title("SERVICEDESK DATABASE CONTROLLER")
    logo = Image.open('icloud_icon.png')
    icon = ImageTk.PhotoImage(logo)
    root.wm_iconphoto(False, icon)

    # Create a Frame to hold the buttons
    frame = tk.Frame(root)
    frame.grid(padx=20, pady=10)
    # frame.pack(side = "right", fill = "both", expand = True)


    # Create the buttons
    # First row
    safe_connect_button = tk.Button(frame, text="Apagar Servicedesk", width=20, command=connect_to_client, font=('Arial', 12))
    already_connected_button = tk.Button(frame, text="Conectar", width=20, command=already_connected, font=('Arial', 12))
    safe_connect_button.grid(row=1, column=1, padx=5, pady=10)
    already_connected_button.grid(row=1, column=2, padx=5, pady=10)
    
    # Second row
    text_input = tk.Text(frame, state='disabled', width=40, height=5)
    text_input.grid(row=2, column=1, columnspan=2, padx=5, pady=10)

    # Third row
    save_data = tk.StringVar(frame)
    save_data.set('Only show')
    option2 = tk.OptionMenu(frame, save_data, "Save", "Only show")
    option2.config(state='disabled')
    option2.grid(row=3, column=1, padx=5, pady=10)
    execute_sql_button = tk.Button(frame, text="Execute Code", width=20, command=execute_code, state="disabled", font=('Arial', 12))
    execute_sql_button.grid(row=3, column=2, padx=5, pady=10)

    # Fourth row 
    square_frame = tk.Frame(frame, bg='#FCEDE2', width=420, height=90)
    square_frame.grid(row=4, column=1, columnspan=2, rowspan=2, padx=5, pady=0)  
    square_frame.config(relief='solid', bd=1)
    compare_db_button = tk.Button(frame, text='Compare Databases', width=20, command=compare_databases, state='disabled', font=('Arial', 12))
    compare_db_button.grid(row=4, column=1, padx=5, pady=0)
    create_dump_button = tk.Button(frame, text="Download Database", width=20, command=download_dump, state="disabled", font=('Arial', 12))
    create_dump_button.grid(row=4, column=2, padx=5, pady=0)
    create_graph_button = tk.Button(frame, text="Create graph", width=20, command=create_graph, state="disabled", font=('Arial', 12))
    create_graph_button.grid(row=5, column=1, padx=5, pady=0)
    add_spaces_button = tk.Button(frame, text="Añadir espacios", width=20, command=add_spaces, state="disabled", font=('Arial', 12))
    add_spaces_button.grid(row=5, column=2, padx=5, pady=0)
    
    # Fifth row
    disconnect_securely_button = tk.Button(frame, text="Iniciar ServiceDesk", width=20, command=disconnect_securely_client, state="disabled", font=('Arial', 12))
    disconnect_securely_button.grid(row=6, column=1, padx=5, pady=10)
    disconnect_button = tk.Button(frame, text="Desconectar", width=20, command=disconnect_client, state="disabled", font=('Arial', 12))
    disconnect_button.grid(row=6, column=2, padx=5, pady=10)


    # Sixth row
    log_output = tk.Text(frame, width=70, height=15, state='disabled', wrap='word', font=('Arial', 8))
    log_output.grid(row=7, column=1, columnspan=2, padx=5, pady=10)
    log_output_scrollbar = tk.Scrollbar(frame, orient='vertical', command=log_output.yview)
    log_output_scrollbar.grid(row=7, column=3, columnspan=2, padx=5, pady=10, sticky='ns')
    log_output.configure(yscrollcommand=log_output_scrollbar.set)


    # Run the main loop
    root.mainloop()


if __name__ == '__main__':
    main()

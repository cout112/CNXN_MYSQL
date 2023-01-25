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
INJECTIONS_PATH = os.path.join(BASE_PATH, 'AUTOMATIC INJECTIONS')






















# -------------------------- HELPER FUNCTIONS -------------------------------
# These functions will perform smaller repetitive tasks. 
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




        

    def get_database_file(prompt_message='Abrir', filename=None):
        """
        Allows the user to select one database from the previously stored dumps.
        """
        database_path = None
        # Get the database to compare to
        if filename is None:
            database_path = filedialog.askopenfilename(title=prompt_message, initialdir=DUMPS_PATH)
            while not database_path.endswith('.sql'):
                log_print(f"File chosen is wrong. Try one ending in .sql")
                database_path = filedialog.askopenfilename(title=prompt_message, initialdir=DUMPS_PATH)
        else:
            database_path = os.path.join(DUMPS_PATH, filename)

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

        dump_file = get_database_file(file_name)

        return dump_file


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
        changed = []
        for i, new_statement in enumerate(new_database):
            if new_statement not in old_database:
                
                # Create table with only new info
                data_table = []
                new_statement_lines = new_statement.split('\n')
                old_database_lines = old_database[i].split('\n')
                for ii, line in enumerate(new_statement_lines):
                    
                    # Create columns
                    if ii == 0:
                        database_name = line.split()[1]
                        data_table.append(database_name)
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


    def shutdown_database():
        """
        Shuts down database.
        """
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
        safe_connect_button.config(state='disabled')
        execute_sql_button.config(state="normal")
        text_input.config(state='normal')
        option2.config(state='normal')
        compare_db_button.config(state='normal')
        disconnect_securely_button.config(state='normal')
        create_dump_button.config(state='normal')
        button6.config(state='normal')
        button7.config(state='normal')
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
        safe_connect_button.config(state='disabled')
        execute_sql_button.config(state="normal")
        text_input.config(state='normal')
        option2.config(state='normal')
        compare_db_button.config(state='normal')
        disconnect_securely_button.config(state='normal')
        create_dump_button.config(state='normal')
        button6.config(state='normal')
        button7.config(state='normal')
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
        if new_database_file is None:
            new_database_file = create_dump()

        # Create comparable data structures
        old_statements = create_statements_list(old_database_file, ['COPY'])
        new_statements = create_statements_list(new_database_file, ['COPY'])

        # Make comparison
        changed = make_database_comparison(old_statements, new_statements)

        # Print new data
        for i, statement in enumerate(changed):
            log_print(f"TABLE: {i+1}", False)
            for line in statement:
                log_print(line, False)

        log_print(f"Changed {len(changed)} tables", False)

        # Save tables to sql statements
        text = ''
        for table in changed:
            for i in range(2, len(table)):
                text += f"INSERT INTO {table[0]}({','.join(table[1])}), values({','.join(table[i])});\n"
        sql_file = filedialog.asksaveasfile(title='SAVE SQL', initialdir=INJECTIONS_PATH)
        sql_file.write(text)
        sql_file.close()
        return None


    def disconnect_securely_client():
        """
        Disconnect from the client and restore security.
        """

        # Shutdown database
        shutdown_database()
        time.sleep(5)

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
        client.close()
        tunnel.close()
        log_print(f"Closed connection without securing it.")
        exit(0)
        return None


    def download_dump():
        create_dump()
        return None

    def button6_clicked():
        filepath = filedialog.askopenfilename(initialdir=BASE_PATH)
        print(filepath)
        # subprocess.call(["./script5.sh", filepath])

    def button7_clicked():
        filepath = filedialog.askopenfilename(initialdir=BASE_PATH)
        print(filepath)
        # subprocess.call(["./script5.sh", filepath])

    
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
    safe_connect_button = tk.Button(frame, text="Connect to client", width=20, command=connect_to_client, font=('Arial', 12))
    already_connected_button = tk.Button(frame, text="Alreay Connected", width=20, command=already_connected, font=('Arial', 12))
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
    button6 = tk.Button(frame, text="Nothing button", width=20, command=button6_clicked, state="disabled", font=('Arial', 12))
    button6.grid(row=5, column=1, padx=5, pady=0)
    button7 = tk.Button(frame, text="Nothing button", width=20, command=button7_clicked, state="disabled", font=('Arial', 12))
    button7.grid(row=5, column=2, padx=5, pady=0)
    
    # Fifth row
    disconnect_securely_button = tk.Button(frame, text="Disconnect securely", width=20, command=disconnect_securely_client, state="disabled", font=('Arial', 12))
    disconnect_securely_button.grid(row=6, column=1, padx=5, pady=10)
    disconnect_button = tk.Button(frame, text="Disconnect", width=20, command=disconnect_client, state="disabled", font=('Arial', 12))
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

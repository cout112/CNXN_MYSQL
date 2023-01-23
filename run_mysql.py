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






















# -------------------------- HELPER FUNCTIONS -------------------------------
# These functions will perform smaller repetitive tasks. 
# They will be called from the structure funcions.

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

def log_print(message):
    log.write(f"[{get_now()}] {message}\n")
    print(f"[{get_now()}] {message}")
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
    log_print(f"Trying to shut down Application daemon.")
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
        log_print(f"Connection successfull...")
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



















# -------------------------- GUI FUNCTIONS -------------------------------
# These functions are componed by a series of instructions defined in the structure 
# functions. They are the functions called by the buttons on the GUI, and they will
# use the structure functions to perform tasks.
# They also change thins in the GUI.

def main():
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
        text_input.pack(expand=True)
        button2.pack(expand=True)
        option2.pack(expand = True)

        button1.config(state='disabled')
        button2.config(state="normal")
        text_input.config(state='normal')
        option2.config(state='normal')
        button3.config(state='normal')
        button5.config(state='normal')


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
        # button2.config(state='disabled')
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
        print(f"Columns: {columns}")
        for line in result:
            print(line)

        # If 'Save' selected, save csv with file
        if save_data.get() == 'Save':    
            df = pd.DataFrame(result_list, columns=columns)
            df.to_csv(os.path.join(BASE_PATH, 'tables.csv'))

        return None

    def disconnect_client():
        """
        Disconnect from the client and restore security.
        """
        
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
        time.sleep(5)

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

        # Run application
        # command = "sudo /home/ManageEngine/ServiceDesk/bin/run.sh"
        # log_print(f"Trying to start application...")
        # try:
        #     client.exec_command(command)
        #     log_print(f"Application started succesfully. It will take a few minutes to be completely deployed.")
        # except Exception as e:
        #     log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Run application
        command = "sudo systemctl start servicedesk"
        log_print(f"Trying to start application...")
        try:
            client.exec_command(command)
            log_print(f"Application started succesfully. It will take a few minutes to be completely deployed.")
        except Exception as e:
            log_print(f"Error executing commands on client terminal. Error: {e}.")

        # Once everything is done, close all connections and end the program.
        
        client.close()
        tunnel.close()
        # log.close()
        # root.destroy()
        log_print(f"Successfully closed connection.")
        exit(0)
        return None

    def button5_clicked():
        filepath = filedialog.askopenfilename(initialdir=BASE_PATH)
        print(filepath)
        # subprocess.call(["./script5.sh", filepath])

    
    # Create the window
    root = tk.Tk()
    root.geometry("400x600") # set the size of the main window
    root.title("MYSQL DATABASE CONTROLLER")
    logo = Image.open('icloud_icon.png')
    icon = ImageTk.PhotoImage(logo)
    root.wm_iconphoto(False, icon)

    # Create a Frame to hold the buttons
    frame = tk.Frame(root)
    frame.pack(side = "right", fill = "both", expand = True)

    # Create variables
    save_data = tk.StringVar(frame)
    save_data.set('Save')

    # Create the buttons
    button1 = tk.Button(frame, text="Connect to client", command=connect_to_client, width = 20, padx = 10, pady = 10, font=('Helvetica', 11))
    text_input = tk.Text(frame, state='disabled', width=40, height=5)
    button2 = tk.Button(frame, text="Execute Code", command=execute_code, state="disabled", width = 30, padx = 30, pady = 30, font=('Helvetica', 12))
    option2 = tk.OptionMenu(frame, save_data, "Save", "Only show")
    option2.config(state='disabled')
    button3 = tk.Button(frame, text="Disconnect securely", command=disconnect_client, state="disabled", width = 20, padx = 10, pady = 10, font=('Helvetica', 11))
    button5 = tk.Button(frame, text="select file", command=button5_clicked, state="disabled", width = 20, padx = 10, pady = 10, font=('Helvetica', 11))


    # Add the buttons to the main window
    button1.pack(expand=True)
    # text_input.pack(expand=True)
    # button2.pack(expand=True)
    # option2.pack(expand = True)
    button3.pack(expand=True)
    # button5.pack(expand=True)

    # Run the main loop
    root.mainloop()


if __name__ == '__main__':
    main()

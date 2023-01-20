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
from sshtunnel import SSHTunnelForwarder
import psycopg2




BASE_PATH = os.getcwd()
SQL_FILES_PATH = os.path.join(BASE_PATH, 'sql')
MYSQL_SERVER = 'localhost'
MYSQL_USER = 'root'
MYSQL_DATABASE = 'facilitiesdesk'
LOGS_FOLDER = os.path.join(BASE_PATH, 'logs')
FD_SCRIPTS_PATH = "/root/ManageEngine/FacilitiesDesk/bin"
NOT_LINUX = True


def get_log():
    current_date = datetime.datetime.today().strftime('%y_%m_%d')
    file_path = os.path.join(LOGS_FOLDER, f'log_asignar_resource_{current_date}.log')
    file = open(file_path, 'a')
    return file

def get_config_file():
    file = open(os.path.join(BASE_PATH, 'config_values.ini'), 'r')
    return file

def get_now():
    return datetime.datetime.now().strftime('%H:%M:%S')

def close_facility_desk(log):
    """
    Checks if the application facility desk is up and running by checking the active processes of the computer.
    If it is running it shuts down using the application shutdown.sh bash script.
    """
    if NOT_LINUX:
        return None
    
    try:
        FD_FUNCIONANDO = len([  process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n')
                                if 'FacilitiesDesk' in process and 'java' in process and 'run.sh' in process])
    except Exception as e:
        log.write(f'{get_now()} Command: ps, -fea -> Error: {e}\n')
        exit(1)
    if FD_FUNCIONANDO > 0:
        log.write(f"{get_now()} FacilitiesDesk ESTA FUNCIONANDO\n")
        subprocess.run(['cd', FD_SCRIPTS_PATH, '&&', './shutdown.sh', '-S'], capture_output=True, text=True)
        log.write(f"{get_now()} Esperando a que la aplicación se detenga...\n")
        CONTADOR = 0
        while CONTADOR < 4 and FD_FUNCIONANDO > 0:
            time.sleep(10)
            FD_FUNCIONANDO = len([  process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') 
                                    if 'FacilitiesDesk' in process and 'java' in process and 'run.sh' in process])
            CONTADOR += 1
        if FD_FUNCIONANDO == 1:
            log.write(f"{get_now()} La aplicación FacilitiesDesk no se ha podido parar\n")
            exit(1)
        else:
            log.write(f"{get_now()} La aplicación FacilitiesDesk se ha parado\n")
    return None

def run_no_socket_db(log):
    if NOT_LINUX:
        return None
    try:
        MYSQL_SOCKET = len([process for process in subprocess.run(["ps", "-fea"], stdout=subprocess.PIPE).stdout.decode("utf-8").split('\n') 
                            if 'FacilitiesDesk' in process and 'mysqld' in process.lower() and 'socket' not in process])
    except Exception as e:

        log.write(f'Command: ps, -fea -> Error: {e}\n')
        exit(1)
    if MYSQL_SOCKET > 0:
        print("MYSQL iniciada en modo sin Socket")
    else:
        print("Iniciando MYSQL sin Socket")
        subprocess.run([f"cd {FD_SCRIPTS_PATH}", "./startDB.sh_sinSocket & >/dev/null 2>&1"])
        time.sleep(10)
        try:
            MYSQL_SINSOCKET = len([process for process in subprocess.run(["ps", "-fea"], stdout=subprocess.PIPE).stdout.decode("utf-8") 
                                if 'FacilitiesDesk' in process and 'mysqld' in process.lower() and 'socket' not in process])
        except Exception as e:
            log.write(f'Command: ps, -fea -> Error: {e}\n')

            exit(1)
        if MYSQL_SINSOCKET == 0:
            print("MYSQL no se ha podido arrancar sin socket")
            exit(1)
        else:
            print("MYSQL sin socket arrancada.")

    print("EJECUCION SCRIPT")


def run_socket_db(log):
    """
    It checks if the database is running in socket mode and shuts down using stopDB.sh bash script.
    """
    if NOT_LINUX:
        return None
    try:
        MYSQL_SOCKET = len([process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') if 'mysqld' in process and 'socket' in process])
    except Exception:
        log.write(f'Command: ps, -fea -> Error {Exception}\n')
        exit(1)
    if MYSQL_SOCKET > 0:
        log.write(f"{get_now()} Parando MYSQL en modo Socket\n")
        subprocess.run(['cd', FD_SCRIPTS_PATH, '&&', './stopDB.sh'], capture_output=True, text=True)
        CONTADOR = 0
        while CONTADOR < 4 and MYSQL_SOCKET > 0:
            time.sleep(10)
            MYSQL_SOCKET = len([process for process in subprocess.run(['ps', '-fea'], capture_output=True, text=True).stdout.decode('utf-8').split('\n') if 'mysqld' in process and 'socket' in process])
            CONTADOR += 1
        if MYSQL_SOCKET > 0:
            log.write(f"{get_now()} MYSQL no se ha podido parar en modo socket\n")
            exit(1)
        else:
            log.write(f"{get_now()} MYSQL parada.\n")

def get_value_from_config(config_file, value):
    for line in config_file.read().split('\n'):
        if value in line:
            return line[len(value)+1:]


def activate_no_socket_protocol():
    #subprocess.call(["./script1.sh"])
    log = get_log()
    config_file = get_config_file()
    close_facility_desk(log)
    run_socket_db(log)
    closed_state_id = get_value_from_config(config_file, 'ESTADO_CERRADO')
    mp_id = get_value_from_config(config_file, 'MP')
    log.write(f"{get_now()} ***PROCESO PARA ASIGNAR LOS RECURSOS A LAS SOLICITUDES DE MP CERRADAS***\n")
    log.write(f"{get_now()} *************************************\n")
    current_date = datetime.datetime.today().strftime('%y_%m_%d')
    log.write(f"{get_now()} FECHA PROCESO: {current_date}\n")
    log.write(f"{get_now()} ***PROCESO PARA ASIGNAR LOS RECURSOS A LAS SOLICITUDES DE MP CERRADAS***\n")
    log.close()
    button1.config(state='disabled')
    button2.config(state="normal")



def connect_database():
    #Connect to database
    # engine=create_engine(f'mysql+mysqlconnector://{MYSQL_USER}@{MYSQL_SERVER}/{MYSQL_DATABASE}')
    
    # connection = engine.connect()
    # log = get_log()
    # global db
    # try:
    #     engine=create_engine('mysql+mysqlconnector://root:Adrive_50!mysql@localhost/facilitydeskdb')
    #     db = scoped_session(sessionmaker(bind=engine))
    # except Exception as e:
    #     log.write(f"{get_now()} Connection to database error: {e}")

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
    # engine = create_engine(f"postgresql://localhost:65432/servicedesk")
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
    # engine = create_engine('postgresql://postgres@89.140.72.212:65432/servicedesk')
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


    # engine = create_engine('postgresql://postgres@:65432/servicedesk')
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
    


    # --------------
    # OPEN A SUSTAINED TUNNEL THROUGH THE CMD PROMT LINE WITH THE NEXT COMMAND
    # ssh -N -L localhost:8888:localhost:65432 root@89.140.72.212
    # ssh -N -L 8888:localhost:65432 root@89.140.72.212
    # This makes an openning and binds together local 8888 port to localhost:65432 on remote computer.
    engine = create_engine('postgresql://postgres:@:8888/servicedesk')
    db = scoped_session(sessionmaker(bind=engine))
    result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
    for table in result:
        print(table[0])
    # --------------



    # --------------
    # transport = ssh_client.get_transport()
    # local_bind_address = ('127.0.0.1', 65432)
    # remote_bind_address = ('127.0.0.1', 65432)
    # transport.request_port_forward('127.0.0.1',65432)
    # --------------


    # engine = create_engine(f"postgresql://localhost:65432/servicedesk")
    # db = scoped_session(sessionmaker(bind=engine))

    # result = db.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""").fetchall()
    # for line in result:
    #     print(result)




    # connection = psycopg2.connect(port=65432, user='postgres', dbname='servicedesk')

    # cursor = connection.cursor()

    # cursor.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema='public';""")

    # tables = cursor.fetchall()

    # for table in tables:
    #     print(table[0])

    # cursor.close()
    # connection.close()

    #Enable rest of buttons if connection is succesful
    button2.config(state='disabled')
    text_input.config(state='normal')
    button3.config(state="normal")
    button4.config(state="normal")
    button5.config(state="normal")
    # subprocess.call(["./script2.sh", filepath])


def execute_code():
    text = text_input.get('1.0', 'end-1c')
    text_input.delete('1.0', 'end')
    
    os.system(text)
    # subprocess.call(["./script3.sh", filepath])

def button4_clicked():
    filepath = filedialog.askopenfilename(initialdir=BASE_PATH)
    print(filepath)
    # subprocess.call(["./script4.sh", filepath])

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

# Create the buttons
button1 = tk.Button(frame, text="Initiate safe mode for database", command=activate_no_socket_protocol, width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
button2 = tk.Button(frame, text="Connect to Database", command=connect_database, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
text_input = tk.Text(frame, state='disabled', width=40, height=5)
button3 = tk.Button(frame, text="Execute Code", command=execute_code, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
button4 = tk.Button(frame, text="Run Script 4", command=button4_clicked, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
button5 = tk.Button(frame, text="Run Script 5", command=button5_clicked, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))

# Change text input size


# Add the buttons to the main window
button1.pack(expand=True)
button2.pack(expand=True)
text_input.pack(expand=True)
button3.pack(expand=True)
button4.pack(expand=True)
button5.pack(expand=True)


# Run the main loop
root.mainloop()


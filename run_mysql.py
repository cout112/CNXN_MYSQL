import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk

import subprocess
import os
import datetime
import time
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
import paramiko




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

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname='89.140.72.212', username='root', password='IH6MFN45Af')

    # Open the SSH Transport
    transport = client.get_transport()

    # Create the tunnel
    local_bind_port = 5432
    remote_bind_address = ('localhost', 8080)
    local_bind_address = ('127.0.0.1', local_bind_port)
    tunnel = transport.open_channel('direct-tcpip', remote_bind_address, local_bind_address)

    # Create the engine
    engine = create_engine(f"postgresql://localhost:8080")
    db = scoped_session(sessionmaker(bind=engine))

    # Make the database call
    result = db.execute('show tables;').fetchall()
    print(result)
    db.commit()


    # Close the tunnel
    tunnel.close()
    client.close()

    #Enable rest of buttons if connection is succesful
    button2.config(state='disabled')
    button3.config(state="normal")
    button4.config(state="normal")
    button5.config(state="normal")
    # subprocess.call(["./script2.sh", filepath])


def button3_clicked():
    filepath = filedialog.askopenfilename(initialdir=BASE_PATH)
    print(filepath)
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
button3 = tk.Button(frame, text="Add", command=button3_clicked, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
button4 = tk.Button(frame, text="Run Script 4", command=button4_clicked, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))
button5 = tk.Button(frame, text="Run Script 5", command=button5_clicked, state="disabled", width = 30, padx = 30, pady = 20, font=('Helvetica', 12))


# Add the buttons to the main window
button1.pack(expand=True)
button2.pack(expand=True)
button3.pack(expand=True)
button4.pack(expand=True)
button5.pack(expand=True)


# Run the main loop
root.mainloop()


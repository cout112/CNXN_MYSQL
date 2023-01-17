import tkinter as tk
from tkinter import filedialog
import subprocess

def button1_clicked():
    #subprocess.call(["./script1.sh"])
    button2.config(state="normal")
    button3.config(state="normal")
    button4.config(state="normal")
    button5.config(state="normal")

def button2_clicked():
    filepath = filedialog.askopenfilename()
    subprocess.call(["./script2.sh", filepath])

def button3_clicked():
    filepath = filedialog.askopenfilename()
    subprocess.call(["./script3.sh", filepath])

def button4_clicked():
    filepath = filedialog.askopenfilename()
    subprocess.call(["./script4.sh", filepath])

def button5_clicked():
    filepath = filedialog.askopenfilename()
    subprocess.call(["./script5.sh", filepath])

# Create the window
root = tk.Tk()
root.geometry("800x600") # set the size of the main window
root.title("Bash Script Runner")

# Create a Frame to hold the buttons
frame = tk.Frame(root)
frame.pack(side = "right", fill = "both", expand = True)

# Create the buttons
button1 = tk.Button(frame, text="Run Script 1", command=button1_clicked, width = 90, padx = 20, pady = 20)
button2 = tk.Button(frame, text="Run Script 2", command=button2_clicked, state="disabled", width = 90, padx = 20, pady = 20)
button3 = tk.Button(frame, text="Run Script 3", command=button3_clicked, state="disabled", width = 90, padx = 20, pady = 20)
button4 = tk.Button(frame, text="Run Script 4", command=button4_clicked, state="disabled", width = 90, padx = 20, pady = 20)
button5 = tk.Button(frame, text="Run Script 5", command=button5_clicked, state="disabled", width = 90, padx = 20, pady = 20)


# Add the buttons to the main window
button1.pack(expand=True)
button2.pack(expand=True)
button3.pack(expand=True)
button4.pack(expand=True)
button5.pack(expand=True)

# Run


# Run the main loop
root.mainloop()


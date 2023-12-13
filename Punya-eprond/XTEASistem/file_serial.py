import serial
from serial.tools import list_ports
import time
import os

def get_port():
    portlist = list_ports.comports()
    for port in portlist:
        print(port)
        

def assign():
    print("insert port: ")
    dock = "COM17"
    print("insert baudrate: ")
    baud = int(115200)
    global ser
    ser = serial.Serial(

        port=dock,
        baudrate=baud,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS, 
        timeout= 0.1
        )

def receive():
    while 1:
        if ser.in_waiting > 0:
            x = ser.readline()
            try:
                print(x.decode())
            except:
                pass
                ser.close()

def send(msg):
    ser.write(bytes(msg, 'utf-8'))
    time.sleep(0.05)

def write_read(x):
    ser.write(bytes(x, 'utf-8'))
    time.sleep(0.05)
    data = ser.readline()
    return data


get_port()
assign()

while True:
    msg = open("")
    send(msg)
    print(ser.in_waiting)
    receive()
    ser.close()
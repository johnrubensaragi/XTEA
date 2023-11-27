import serial
import os
import time
from serial.tools import list_ports

def get_port():
    portlist = list_ports.comports()
    for port in portlist:
        print(port)

def assign():
    print("insert port: ")
    dock = "COM17"
    print("insert baudrate: ")
    baud = int(9600)
    global ser
    ser = serial.Serial(
        port=dock,
        baudrate=baud,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_TWO,
        bytesize=serial.EIGHTBITS, timeout=0.1
        )


def write_read(x):
    ser.write(x)
    time.sleep(0.05)
    data = ser.readline()
    return data

def rewrite(x):
    file = open("test.txt", "w")
    file.write(x)

msg = open("test.txt", 'b')

data = write_read(msg.read())



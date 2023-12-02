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
    dock = "COM14"
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
    ser.write(bytes(x, 'utf-8'))
    time.sleep(0.05)
    data = ser.readline()
    return data

def rewrite(x):
    file = open("XTEA/Serial Yoga/test.txt", "w")
    file.write(x.decode())
    file.close()

get_port()
assign()
while True:
    msg = open("XTEA/Serial Yoga/test.txt", 'r')
    data = write_read(msg.read().encode())
    msg.close()
    rewrite(data)
    print(data.decode())


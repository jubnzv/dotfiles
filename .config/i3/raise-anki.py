#!/usr/bin/env python3
import socket
import sys

sock_path = '/tmp/anki_tray.sock'

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
try:
    sock.connect(sock_path)
except socket.error as msg:
    print(msg)
    sys.exit(1)

sock.close()

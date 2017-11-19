#!/usr/bin/python2.7
import sys
import os.path
import requests

def usage():
    print("Usage: {} <kata_slug>".format(sys.argv[0]))
    print("\tPython template code <kata_slug>.py will be created.")

if len(sys.argv) != 2:
    usage()
    sys.exit()

url = "https://www.codewars.com/api/v1/code-challenges/" + sys.argv[1]
json = requests.get(url).json()
filename = sys.argv[1] + '.py'

if os.path.isfile(filename):
    print("File {} already exists! Exiting...".format(filename))
    sys.exit(17)

with open(sys.argv[1] + '.py', 'w') as f:
    f.write("'''\n")
    f.write(json["url"] + '\n\n')
    f.write(json["description"] + '\n')
    f.write("'''\n")
    print("{} is ready.".format(filename))


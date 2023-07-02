#!/usr/bin/python3
import os
import subprocess
import sys


def convert(pdf_file):
    input_file = os.path.join(pdf_file)
    output_file = os.path.splitext(input_file)[0] + '_s.pdf'
    command = ['dangerzone-cli', input_file, '--output-filename', output_file]
    subprocess.run(command, check=True)
    print(f"Converted '{pdf_file}' to the safe version.")


def convert_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".pdf"):
                file_path = os.path.join(root, file)
                convert(file_path)


if __name__ == '__main__':
    if len(sys.argv) == 2:
        pdf_directory = sys.argv[1]
        if not os.path.isdir(pdf_directory):
            print(f'{pdf_directory} is not directory')
            exit(1)
    else:
        print(f'Usage: {sys.argv[0]} <DIR>')
        exit(1)
    convert_directory(pdf_directory)

#!/usr/bin/python3
import pdfkit
import sys


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print(f'Usage: {str(sys.argv[0])} <site> <pdf filename>')
        sys.exit(1)
    pdfkit.from_url(sys.argv[1], sys.argv[2])

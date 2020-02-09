#!/usr/bin/env python3
import httplib2
import requests
from bs4 import BeautifulSoup, SoupStrainer

URL = 'https://www.alchemistowl.org/pocorgtfo/'

http = httplib2.Http()
status, response = http.request(URL)

for link in BeautifulSoup(response, parse_only=SoupStrainer('a')):
    try:
        if link['href'].endswith('.pdf'):
            print("saving " + URL + link['href'])
            h = httplib2.Http()
            _, content = h.request(URL + link['href'])
            print("writing file")
            with open(link['href'], 'wb') as f:
                f.write(content)
    except:
        pass

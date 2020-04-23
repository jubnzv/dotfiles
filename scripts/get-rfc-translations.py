#!/usr/bin/env python3
# Download pdfs with RFC translations from https://www.protocols.ru/WP/rfc/
import asyncio
import aiohttp
import requests
import os
import logging
from urllib.parse import urljoin
from bs4 import BeautifulSoup

logging.basicConfig(level=logging.DEBUG,
                    format='[%(asctime)s,%(msecs)d] %(name)s %(levelname)s %(message)s',
                    datefmt='%H:%M:%S')

URLS = [f'https://www.protocols.ru/WP/rfc{i}/' for i in range(9)]
LOCATION = r'/home/jubnzv/Documents/Web/RFC/'


def save_pdfs(url, data):
    soup = BeautifulSoup(data, "html.parser")
    for link in soup.select("a[href$='.pdf']"):
        filename = os.path.join(LOCATION, link['href'].split('/')[-1])
        logging.debug(f'Saving {link} as {filename}')
        with open(filename, 'wb') as f:
            f.write(requests.get(urljoin(url, link['href'])).content)


async def download_pdfs(url):
    logging.debug(f'Processing {url}...')
    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            status = response.status
            if status != 200:
                logging.error(f"Can't get {url}: status={status}")
                return
            data = await response.read()
            save_pdfs(url, data)


async def asynchronous():
    download_pdfs_tasks = [download_pdfs(url) for url in URLS]
    while download_pdfs_tasks:
        done, download_pdfs_tasks = await asyncio.wait(download_pdfs_tasks)


if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(asynchronous())
    loop.close()

#!/usr/bin/python3
#
# Script that asynchronously checks SSL expiration date for domains specified
# in DOMAINS variable.
#
import asyncio
import OpenSSL
import ssl
import concurrent.futures
from datetime import datetime
from email.mime.text import MIMEText
from subprocess import Popen, PIPE

# Replace with your domains
DOMAINS = ['www.foxnews.com',
           'www.cnn.com',
           'europe.wsj.com',
           'www.bbc.co.uk',
           'some-made-up-domain.com']


def send_email_notify(text):
    msg = MIMEText(text)
    msg["From"] = "noreply@localhost"
    msg["To"] = "jubnzv@remilia"
    msg["Subject"] = "SSL expiration warning"
    p = Popen(["/usr/sbin/sendmail", "-t", "-oi"], stdin=PIPE)
    p.communicate(msg.as_string())


def show_libnotify(text):
    p = Popen(["notify-send", "-u", "critical",
               "SSL expiration warning", text])


def get_ssl_expiration_date(domain):
    # print(f"Checking {domain}...")
    cert = ssl.get_server_certificate((domain, 443))
    x509 = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, cert)
    # print(f"{domain} done")
    return datetime.strptime(x509.get_notAfter().decode('ascii'), '%Y%m%d%H%M%SZ')


async def async_check(loop):
    send_text = []

    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        future_to_domain = {executor.submit(
            get_ssl_expiration_date, d): d for d in DOMAINS}
        for future in concurrent.futures.as_completed(future_to_domain):
            domain = future_to_domain[future]
            try:
                expire_date = future.result()
                date_diff = expire_date - datetime.now()
                if date_diff.days < 21:
                    send_text.append(
                        f"{domain} will expire in {date_diff.days} days!")
                else:
                    print(f"[LOG] {domain}: {date_diff.days} days left.")
            except Exception as exc:
                print(f'{domain} generated an exception: {exc}')

    return send_text


if __name__ == "__main__":
    ioloop = asyncio.get_event_loop()
    send_text = ioloop.run_until_complete(async_check(ioloop))
    ioloop.close()

    if send_text:
        msg = "\n".join(send_text)
        send_email_notify(msg)
        show_libnotify(msg)

    if send_text:
        print("There are following problems:", "\n".join(send_text))
    else:
        print("No problems found. Check domains: %s" % " ".join(DOMAINS))

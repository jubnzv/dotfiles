#!/usr/bin/env python3
#
# Get anki cards added today and email them to localhost.
#
import sqlite3
import datetime

from email.mime.text import MIMEText
from subprocess import Popen, PIPE


ANKI_COL = "/home/jubnzv/.local/share/Anki2/1-й пользователь/collection.anki2"


def daystart_ms():
    today = datetime.datetime.now().date()
    return int(round(datetime.datetime(
        year=today.year,
        month=today.month,
        day=today.day).timestamp())*1000)


def get_today_cards_num():
    conn = sqlite3.connect(ANKI_COL)
    cursor = conn.cursor()
    cursor.execute(f"SELECT * FROM cards WHERE (id > {daystart_ms()});")
    res = cursor.fetchall()
    return len(res)


def send_mail(num, text=""):
    today_str = datetime.datetime.now().strftime("%Y-%m-%d")
    msg = MIMEText("")
    msg["From"] = "jubnzv@remilia"
    msg["To"] = "jubnzv@remilia"
    msg["Subject"] = f"Anki cards {today_str}: {str(num)}"
    p = Popen(["/usr/sbin/sendmail", "-t", "-oi"], stdin=PIPE)
    p.communicate(msg.as_bytes())


if __name__ == '__main__':
    cards_num = get_today_cards_num()
    send_mail(cards_num)

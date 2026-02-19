#!/usr/bin/env python3

from datetime import datetime
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart
from playwright.sync_api import Playwright, sync_playwright, expect
import re
import smtplib
import sys
import os
import signal
import time

# Here are the email package modules we'll need.
from email.message import EmailMessage

global_ImgFileName = ""
# global_run = True


# def my_signal_handler(signum, frame):
#     print(f"\nReceived signal: {signum} ({signal.Signals(signum).name})")
#     print("Performing cleanup and exiting...")
#     global global_run
#     global_run = False
# sys.exit(0)


def citation_exists(citation_number) -> bool:
    global global_ImgFileName
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch()
        context = browser.new_context()
        page = context.new_page()
        page.goto("https://webpay.courts.state.mn.us/CourtWebPay/default.aspx")
        page.get_by_role("link", name="Citation or Case.").click()
        page.get_by_role("textbox", name="* Citation Number").fill(citation_number)
        page.get_by_role("button", name="Search").click()
        found_citation = not page.get_by_text(
            "No cases matched your search"
        ).is_visible()
        if found_citation:
            formatted_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            global_ImgFileName = f"/home/andrewpierson/Pictures/citations/{formatted_datetime}_{citation_number}.png"
            page.screenshot(path=global_ImgFileName)
        context.close()
        browser.close()
    return found_citation


def main():

    # global global_run
    # # Register the custom handler for SIGINT (Ctrl+C)
    # signal.signal(signal.SIGINT, my_signal_handler)

    # while global_run:
    while True:
        for citation in range(271125216988, 271125216999):
            formatted_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            if citation_exists(str(citation)):
                print(f"{formatted_datetime}, {citation}, found ")
            else:
                print(f"{formatted_datetime}, {citation}, nothing")

    print("exiting")


if __name__ == "__main__":
    main()

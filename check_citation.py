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

# Here are the email package modules we'll need.
from email.message import EmailMessage

global_ImgFileName = ""


def send_email(subject, body, recipients, password):

    global global_ImgFileName

    YOUR_GOOGLE_EMAIL = "ajp442@gmail.com"

    msg = EmailMessage()
    msg["Subject"] = subject
    msg["From"] = YOUR_GOOGLE_EMAIL
    msg["To"] = ", ".join(recipients)
    msg.set_content(body)
    with open(global_ImgFileName, "rb") as f:
        img_data = f.read()
        msg.add_attachment(img_data, maintype="image", subtype="png")

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtpserver:
        smtpserver.login(YOUR_GOOGLE_EMAIL, password)
        # Test send mail
        sent_from = YOUR_GOOGLE_EMAIL
        # smtpserver.sendmail(sent_from, recipients, msg.as_string())
        smtpserver.send_message(msg)


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
            print(global_ImgFileName)
            page.screenshot(path=global_ImgFileName)
        context.close()
        browser.close()
    return found_citation


def main():

    password = sys.argv[1]
    citations = [
        (["ajp442@gmail.com"], "271125216998"),
        (["hargreavesdahs@gmail.com", "ajp442@gmail.com"], "271125116996"),
    ]
    for citation in citations:
        formatted_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        if citation_exists(citation[1]):
            send_email(
                f"Found citation {citation[1]}",
                r"Welp, looks like they finally cleaned out the meter maid's cubby. ¯\_(ツ)_/¯",
                citation[0],
                password,
            )
            print(f"[{formatted_datetime}] citation {citation[1]} found")
        else:
            print(f"[{formatted_datetime}] citation {citation[1]} nothing")


if __name__ == "__main__":
    main()

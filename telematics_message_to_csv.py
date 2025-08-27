#!/usr/bin/env python3

import csv
import re
import sys

# Quick and dirty script that uses regex to parse out field-computer telematics messages querried from S3.


# Example messagebody
# {seq=722181, time=2024-08-09T13:58:30Z, type=fieldComputerTelematics, payload={products=[{capacity={ddi=138, value=0}, actual={ddi=75, value=0}, nodeid=1}, {capacity={ddi=393, value=-1}, actual={ddi=390, value=-1}, nodeid=2}], allsectionsoff=true, duration=9793, machinestate=idle, durationarea=0.0, leftboomfoldstate=unavailable, vehicleisstopped=true, sessionarea=0.0, jobguid=00000000-0000-0000-0000-000000000000, jobstatus=out-of-job, jobsessionid=0, mechanicalsystemlockout=unavailable, rightboomfoldstate=unavailable, sog={duration=0, max=0.0, mean=0.0, min=0.0}}, location={latitude=null, longitude=null, age=40}}


def main():
    with open(sys.argv[1], "r") as file:
        csvreader = csv.reader(file)

        # First line is the headder, disregard for now.
        header = next(csvreader)

        # One giant regex to parse the various pices we are interested in.
        payload_regex = re.compile(
            r"seq=(?P<seq>\d*), time=(?P<time>\S*), .*allsectionsoff=(?P<allsectionsoff>\S*), duration=(?P<duration>\d*), machinestate=(?P<machinestate>\S*), durationarea=(?P<durationarea>\S*), leftboomfoldstate=(?P<leftboomfoldstate>\S*), vehicleisstopped=(?P<vehicleisstopped>\S*), sessionarea=(?P<sessionarea>\S*), jobguid=(?P<jobguid>\S*), jobstatus=(?P<jobstatus>\S*), jobsessionid=(?P<jobsessionid>\d*), mechanicalsystemlockout=(?P<mechanicalsystemlockout>\S*), rightboomfoldstate=(?P<rightboomfoldstate>\S*), sog={duration=(?P<sog_duration>\d), max=(?P<sog_max>\S*), mean=(?P<sog_mean>\S*), min=(?P<sog_min>\S*)}}, location={latitude=(?P<lat>\S*), longitude=(?P<lon>\S*), age=(?P<age>\d*)}}"
        )

        # The named capture groups that we are parsing out.
        # Pulling double-duty as the csv headder.
        data = [
            [
                "seq",
                "time",
                "allsectionsoff",
                "duration",
                "machinestate",
                "durationarea",
                "leftboomfoldstate",
                "vehicleisstopped",
                "sessionarea",
                "jobguid",
                "jobstatus",
                "jobsessionid",
                "mechanicalsystemlockout",
                "rightboomfoldstate",
                "sog_duration",
                "sog_max",
                "sog_mean",
                "sog_min",
                "lat",
                "lon",
                "age",
            ]
        ]

        # Row 5 is the "messagebody" that we are interested in parsing out
        # and appending to our "table" that we will eventually write out in
        # csv format.
        for row in csvreader:
            r = payload_regex.search(row[5])
            data.append([r[x] for x in data[0]])

    # Write to csv format
    spamwriter = csv.writer(sys.stdout)
    for d in data:
        spamwriter.writerow(d)


if __name__ == "__main__":
    main()

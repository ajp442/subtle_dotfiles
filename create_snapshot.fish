#!/usr/bin/env fish

source logging.fish

function show_help
echo -e "\
usage: $SCRIPT_NAME  [-h] [-v] [-q] [-t "$UNDERLINE"nametag"$NC"] DEVICE 

Take a snapshot of the state of the device.

example usage:
$SCRIPT_NAME CoreDump*.crdp | tee summary.csv


positional arguments:
    DEVICE
        The ip address or hostname of the device to get a snapshot of.

optional arguments:
    -h, --help
        Displays this help message.

    -t "$UNDERLINE"nametag"$NC", --tag "$UNDERLINE"nametag"$NC"
        A small annotation to help identify the thing that we are snapshotting.

    -q, --quiet
        Decreases output level.

    -v, --verbose
        Increases the output level.
"
end

# Parse arguments passed into this script.
argparse --name=$SCRIPT_NAME 'h/help' 'v/verbose' 'q/quiet' 't/tag=' -- $argv; or exit


set VERBOSITY (math $VERBOSITY + (count $_flag_verbose) - (count $_flag_quiet))

# Show help if no arguments passed, or help flag was specified.
if set -q _flag_help; or test -z "$argv"; 
    show_help
    # Return error code if help flag was not set.
    if not set -q _flag_help
        exit $FAILURE
    end
end

# Positional argument
set DEVICE $argv

set dirname (date +"%F_%H_%M")
if set -q _flag_tag
    set dirname "$_flag_tag"_"$dirname"
end

mkdir $dirname

#/usr/bin/raven/userFiles/Jobs
#/usr/bin/raven/userFiles/RxMaps
#/usr/bin/raven/userFiles/TASKDATA
#/usr/bin/raven/userFiles/WorkOrder
#/usr/bin/raven/userFiles/abLines
#/usr/bin/raven/userFiles/agxFiles
#/usr/bin/raven/userFiles/jobResources
#/usr/bin/raven/userFiles/scoutRoot
#/usr/bin/raven/userFiles/slingshotArchives
#/usr/bin/raven/userFiles/usbService


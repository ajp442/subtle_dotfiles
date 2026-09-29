#!/usr/bin/env fish

# Global variable for the name of this script.
# Need this for logging
set SCRIPT_NAME (basename (status -f))

source ~/.config/fish/my_fish_stuff/logging.fish

set snapshot_script "create_snapshot.sh"

function diff_table
    set tablename $argv[1]
    set table_a (mktemp)
    set table_b (mktemp)
    sqlite3 $DIR_A/databases/my.db.sqlite "select * from $tablename;" > $table_a
    sqlite3 $DIR_B/databases/my.db.sqlite "select * from $tablename;" > $table_b

    # Only print stuff if there is a difference
    if not diff $table_a $table_b > /dev/null
        echo "---- $tablename ----"
        if test $VERBOSITY -ge 2
            sqlite3 $DIR_A/databases/my.db.sqlite ".schema $tablename"
        end
        diff $table_a $table_b --color='always' | tail -n +2
        echo
    end

    rm $table_a
    rm $table_b
end

function show_help
echo -e "\
usage: $SCRIPT_NAME  [-h] [-v] [-q] DIR_A DIR_B

Summarise the difference between two directories created from $snapshot_script

example usage:
$SCRIPT_NAME before_job_2026-02-19_13_12/ after_job_2026-02-19_13_22/


positional arguments:
    DIR_A
        Directory to compare.

    DIR_B
        Directory to compare.

optional arguments:
    -h, --help
        Displays this help message.

    -q, --quiet
        Decreases output level.

    -v, --verbose
        Increases the output level.
"
end

# Parse arguments passed into this script.
argparse --name=$SCRIPT_NAME 'h/help' 'v/verbose' 'q/quiet' -- $argv; or exit

set VERBOSITY (math $VERBOSITY + (count $_flag_verbose) - (count $_flag_quiet))

# Show help if no arguments passed, or help flag was specified.
if set -q _flag_help; or test (count $argv) -lt 2; 
    show_help
    # Return error code if help flag was not set.
    if not set -q _flag_help
        exit $FAILURE
    end
    exit $SUCCESS
end


# Positional argument
set DIR_A $argv[1]
set DIR_B $argv[2]

# info "DIR_A: $DIR_A"
# info "DIR_B: $DIR_B"

echo "============= userFiles ============="
# Filter out items that have not been changed (start with a '.')
# https://dev.to/alexisayenko/understanding-rsync-itemize-changes-5fgi
rsync --info=name --delete -anci $DIR_B/userFiles/ $DIR_A/userFiles/ | grep -v '^\.'
echo

echo "============= Database ============="
diff_table growers
diff_table farms
diff_table fields
diff_table files
diff_table cloudJobScoutGroups
diff_table cloudJobs
diff_table workOrderRxMaps
diff_table fileTransferInfo
echo

echo "============= ICE Job List ============="
# To make the jobs lists more "diffable", we will replace the first [ in the
# entire file with a space, then replace the last occurance of ] in the entire
# file with a comma. We will use temp files as to not tamper with the original
# data.
set jobList_a (mktemp)
set jobList_b (mktemp)
sed '0,/\[/{s/\[/ /}' $DIR_A/jobList.txt > $jobList_a
sed '0,/\[/{s/\[/ /}' $DIR_B/jobList.txt > $jobList_b
sed -i '$ s/\\(.*\\)]/\1,/' $jobList_a
sed -i '$ s/\\(.*\\)]/\1,/' $jobList_b
diff $jobList_a $jobList_b --color='always' | tail -n +2
rm $jobList_a
rm $jobList_b
echo


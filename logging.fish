# Verbosity of log level
set VERBOSITY 1

# Global variable for the name of this script.
set SCRIPT_NAME (basename (status -f))

# Global variables for return status.
set SUCCESS 0
set SKIPPING 1
set FAILURE 2

set GREEN '\033[32m'
set YELLOW '\033[33m'
set RED '\033[0;31m'
set NC '\033[0m' # No Color

function debug
    if test $VERBOSITY -ge 2
        echo -e (date +"%T") $GREEN"DEBUG"$NC $SCRIPT_NAME "$argv" 1>&2
    end
end

function info
    if test $VERBOSITY -ge 1
        echo -e (date +"%T") $YELLOW"INFO "$NC $SCRIPT_NAME "$argv" 1>&2
    end
end

function warn
    if test $VERBOSITY -ge 0
        echo -e (date +"%T") $RED"WARN "$NC $SCRIPT_NAME "$argv" 1>&2
    end
end

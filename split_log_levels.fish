#!/usr/bin/env fish

set logfile $argv[1]
set logfile_DEBUG "$logfile""_DEBUG"
set logfile_INFO "$logfile""_INFO"
set logfile_WARN "$logfile""_WARN"
set logfile_ERROR "$logfile""_ERROR"
set logfile_FATAL "$logfile""_FATAL"

if not rg -v "TRACE" $logfile > $logfile_DEBUG
    echo "No DEBUG messages or higher"
    rm $logfile_DEBUG
end
if not rg -v "DEBUG" $logfile_DEBUG > $logfile_INFO
    echo "No INFO messages or higher"
    rm $logfile_INFO
end
if not rg -v "INFO" $logfile_INFO > $logfile_WARN
    echo "No WARN messages or higher"
    rm $logfile_WARN
end
if not rg -v "WARN" $logfile_WARN > $logfile_ERROR
    echo "No ERROR messages or higher"
    rm $logfile_ERROR
end
if not rg -v "ERROR" $logfile_ERROR > $logfile_FATAL
    echo "No FATAL messages or higher"
    rm $logfile_FATAL
end

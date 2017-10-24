#!/bin/bash

# set to 1 if process was detected and we are logging data
SAVING=0

LOG_NAME="log" # it log number will be appended with .txt
LOG_NR=1
LOG="?"

# previously seen data from ps
LAST_VSZ="?"
LAST_RSS="?"

function save_data()
{
    # line has data
    VSZ=`echo $1 | awk '{print $5; }'`
    RSS=`echo $1 | awk '{print $6; }'`

    if [ $VSZ != $LAST_VSZ -o $RSS != $LAST_RSS ]
    then
        now=`date "+%Y-%m-%d %H:%M:%S"`
        line="$now, $VSZ, $RSS"
        echo $line >> $LOG
        echo $line

        LAST_VSZ=$VSZ
        LAST_RSS=$RSS
    fi
}

while true
do
    # clear
    # ps uax | head -1
    # ps uax | grep "[p]ython app.py"
    line=`ps uax | grep "[p]ython app.py"`

    if [ $SAVING == 1 ]
    then
        if [ -z "$line" ]
        then
            echo "Saving finished, because process is not there"
            SAVING=0
        else
            save_data "$line"
        fi
    else # SAVING == 0
        if [ ! -z "$line" ]
        then
            echo "Saving started (datetime, VSZ, RSS)"
            SAVING=1
            LOG="$LOG_NAME$LOG_NR.txt"
            LOG_NR=$((LOG_NR+1))
            LAST_VSZ="?"
            LAST_RSS="?"
            echo "datetime, VSZ, RSS"

            save_data "$line"
        fi
    fi

    sleep 1
done

#!/bin/bash

LOGDIR="$(pwd)/logs/"

if [[ ! -d $LOGDIR ]]; then
    mkdir $LOGDIR
fi
LOGFILE="$LOGDIR/mylog.$$.log"


echo "Log entry" > "$LOGFILE"
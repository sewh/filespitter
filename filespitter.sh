#!/bin/bash

## filespitter.sh
##
## Sometimes it's a pain to keep setting up reverse netcat listeners
## when you want to download several files. This creates a loop
## that asks for a filename and then sets up the correct listener
## for you.
##
## Usage: filespitter port [ssl]
##
## -sewh

echo '[*] Starting filespitter'


# Check for help
if [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
    echo "Usage: filespitter port [ssl]"
    exit 0
fi


# Get a port
PORT="$1" 
echo "[*] Will be listening on port $PORT"


# Check to see if we should be using SSL
if [ "$2" == 'ssl' ] || [ "$2" == "true" ]
then
    echo "[*] Using SSL"
    USE_SSL=1
else
    echo "[!] Not using SSL"
    USE_SSL=0
fi


# Main loop
while [ true ]
do
    read -p '[*] Where shall I save this file > ' FILENAME
    echo '[*] Starting listener...'
    if [ $USE_SSL == 1 ]
    then
        ncat --ssl -nvl $PORT > $FILENAME
    else
        ncat -nvl $PORT > $FILENAME
    fi
    echo "[+] Saved file to $FILENAME!"
done
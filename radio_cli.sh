#!/bin/bash

# URL of the radio stream
RADIO_URL="https://klassikr.streamabc.net/klr-kratnational-mp3-192-4723869"

# the name of the output file added by date
OUTPUT_FILE="klassik_radio_oesterreich_$(date +'%Y-%m-%d_%H-%M-%S').mp3"

# check if mpv and curl is installed
if ! command -v mpv &> /dev/null
then
    echo "mpv is not installed. Installing mpv..."
    sudo apt update && sudo apt install mpv -y
    exit 1
fi

if ! command -v curl &> /dev/null
then
    echo "curl is not installed. Installing curl..."
    sudo apt update && sudo apt install curl -y
    exit 1
fi

# download and play the radio stream
echo "Downloading and playing radio stream..."

# fetch the radio stream and save it to a file and play it with mpv
curl -s "$RADIO_URL" | tee "./saved-streams/$OUTPUT_FILE" | mpv --no-video -

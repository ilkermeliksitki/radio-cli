#!/bin/bash

DIRECTORY="/home/melik/Documents/projects/radio-cli/saved-streams/"
# Size limit in bytes 3MB
SIZE_LIMIT=$((1*1024*1024))
echo $SIZE_LIMIT

# check if the directory size exceeds the limit
CURRENT_SIZE=$(du -sb "$DIRECTORY" | cut -f1)

if [ "$CURRENT_SIZE" -gt "$SIZE_LIMIT" ]; then
    echo "Directory size exceeds the limit. Cleaning up..."

    # Find and delete the oldest .mp3 files until the total size is under the limit
    find "$DIRECTORY" -name "*.mp3" -type f -printf "%T+ %p\n" | sort | while read -r line; do
        FILE=$(echo "$line" | cut -d ' ' -f2-)
        FILE_SIZE=$(stat -c %s "$FILE")
        CURRENT_SIZE=$(($CURRENT_SIZE - $FILE_SIZE))
        
        # Delete the file if it is older and the size still exceeds the limit
        rm "$FILE"
        echo "Deleted: $FILE"

        # If the total size is now under the limit, stop
        if [ "$CURRENT_SIZE" -le "$SIZE_LIMIT" ]; then
            break
        fi
    done
else
    echo "Directory size is within the limit. No action needed."
fi


#!/bin/bash

if [ -z "$1" ]; then
    echo "Remove html tags from text file"
    echo 'cleanhtml INPUT_FILE'
    exit 1
fi

cat "$1" | sed 's/<[^>]*>/ /g'

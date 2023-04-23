#!/bin/bash

if [ -z "$2" ]; then
    echo "Extract new words from raw text file and by stop words file"
    echo 'newwords INPUT_FILE STOP_WORDS_FILE'
    exit 1
fi

cat "$1" | tr 'A-Z' 'a-z' | tr -d [:punct:] |  tr -d [:digit:] | tr -sc 'a-z' '\12' | fgrep -vwf "$2" | sort | uniq


# cat input.srt | tr 'A-Z' 'a-z' | tr -d [:punct:] |  tr -d [:digit:] > input_cleaned.srt 
# cat input_cleaned.srt | tr -sc 'a-z' '\12'> input_tokens.txt
# cat input_tokens.txt | fgrep -vwf known_words_en.txt | sort | uniq > new_words.txt

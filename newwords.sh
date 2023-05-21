#!/bin/bash
# This script can be useful when you only need to extract new words from any subtitle/book file


if [ -z "$2" ]; then
    echo "Extract new words from raw text file and by stop words file"
    echo 'newwords INPUT_FILE STOP_WORDS_FILE'
    exit 1
fi

if [ "$3" == "de" ]; then
    # German
    cat "$1" | sed 's/<[^>]*>/ /g' | sed -r 's/^([A-ZÄÖÜ])/\L\1/g' | sed -r 's/([-.?!]\s+)([A-ZÄÖÜ])/\1\L\2/g' \
    | tr -d [:digit:] | sed -r 's/(\w)-(\w)/\1№№№\2/g' | tr -d [:punct:] | tr -sc 'A-ZÄÖÜa-zäöüßẞ№' '\12' \
    | sed -r 's/(\w)№№№(\w)/\1-\2/g'| fgrep -vwf "$2" | sort | uniq
    exit 0
fi

# English
cat "$1" | sed 's/<[^>]*>/ /g' | tr 'A-Z' 'a-z' |  tr -d [:digit:] | sed -r 's/(\w)-(\w)/\1№№№\2/g' | tr -d [:punct:] \
| tr -sc 'a-z№' '\12' | sed -r 's/(\w)№№№(\w)/\1-\2/g' | fgrep -vxf "$2" | sort | uniq

# cat "$1" | sed 's/<[^>]*>/ /g' # clean html tags
# cat input.srt | tr 'A-Z' 'a-z' | tr -d [:punct:] |  tr -d [:digit:] # clean text from punct. signs and digits
# cat input_cleaned.srt | tr -sc 'a-z' '\12' # get separate tokens
# cat input_tokens.txt | fgrep -vwf known_words_en.txt | sort | uniq # final result
# sed -r 's/(\w)-(\w)/\№№№\2/g' # replace "-" by "№№№" to preserve it from deleting

# German related
# sed -r 's/^([A-ZÄÖÜ])/\L\1/g' # lower case first leters at the begining of sentence
# sed -r 's/([-.?!]\s+)([A-ZÄÖÜ])/\1\L\2/g' # # lower case first leters at the begining of sentence

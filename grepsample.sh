#!/bin/bash
# output first matched line from second file for each line from first file


if [ $# -ne 2 ]; then
  echo "Usage: $0 <file1> <file2>"
  echo "output first matched line from second file for each line from first file"
  echo "Example: $0 file1 file2 | column -t -l 2"
  exit 1
fi

file1=$1
file2=$2

while read -r line; do
  # remove new lines
  line=`echo $line | tr -d "\n\r"`
  # get first matched sample
  sample=`grep -iw "$line" $file2 | head -1 | sed 's/<[^>]*>/ /g' | sed 's/^ *//g'`
  echo -e "$line\t$sample"
done < "$file1"

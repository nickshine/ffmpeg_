#!/bin/bash 

set -e

green='\033[0;32m'
nc='\033[0m'

usage () {
echo -e "$green"
cat <<USAGE
⚠️  ffmpeg must be installed ⚠️

Usage:

  ffmpeg_concat [file ...]

  Example:

     1) Concat all .mkv files in current directory:

       ffmpeg_concat *.mkv

  Output will 'output_concat.mkv'.

USAGE

exit
}

if ! command -v ffmpeg &> /dev/null || [ "$#" -lt 1 ]; then
  usage
fi

tmp_list=$(mktemp /tmp/list.XXXX)

for f in "$@"; do
  echo "file '$PWD/$f'" >> "$tmp_list"
done

echo -e "\n${green}📜 tmp list 📜${nc}\n"

cat $tmp_list

echo -e "\n${green}Concatenating clips...${nc}"
ffmpeg -f concat -safe 0 -i $tmp_list -c copy $PWD/output_concat.mkv

rm $tmp_list

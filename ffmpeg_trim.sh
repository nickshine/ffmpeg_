#!/bin/bash

set -e

green='\033[0;32m'
nc='\033[0m'

usage () {
echo -e "$green"
cat <<USAGE
⚠️  ffmpeg must be installed ⚠️

Usage:

  ./ffmpeg_trim.sh <input file> <start> [end]

  Example:

     1) Trim start of video at the 52 min mark:

       ./ffmpeg_trim.sh input.mkv 00:52:00

     2) Trim video to start at 5 min mark and end at 10 min mark:

       ./ffmpeg_trim.sh input.mkv 00:05:00 00:10:00

  Output will be same name as input file with '_trim' appended.

USAGE

exit
}

if ! command -v ffmpeg &> /dev/null || [ "$#" -lt 2 ]; then
  usage
fi

output_file="${1%.*}_trim.${1##*.}"

if [ "$#" -eq 2 ]; then
  echo -e "\n${green}✂️  Trimming start to '$2' mark ✂️ ${nc}\n"

  ffmpeg -ss $2 -i $1 -c copy $output_file

elif [ "$#" -eq 3 ]; then
  echo -e "\n${green}✂️  Trimming from '$2' to '$3' ✂️ ${nc}\n"

  ffmpeg -ss $2 -to $3 -i $1 -c copy $output_file

else
  usage
fi

echo -e "\n${green}Output to '$output_file'${nc}\n"

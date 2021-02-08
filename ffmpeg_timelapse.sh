#!/bin/bash

set -e

green='\033[0;32m'
nc='\033[0m'

usage () {
echo -e "$green"
cat <<USAGE
⚠️  ffmpeg must be installed ⚠️

Usage:

  ffmpeg_timelapse <input file> <factor>

  Example:

     1) Speed up video by 60x:

       ffmpeg_timelapse input.mkv 60

  Output will be same name as input file with '_timelapse' appended.

USAGE

exit
}

if ! command -v ffmpeg &> /dev/null || [ "$#" -ne 2 ]; then
  usage
fi

output_file="${1%.*}_timelapse.${1##*.}"

echo -e "\n${green} 🕙 Speeding up footage by '$2x' 🕔 ${nc}\n"

ffmpeg -i $1 -filter:v "setpts=PTS/$2" $output_file

echo -e "\n${green}Output to '$output_file'${nc}\n"


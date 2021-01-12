#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - -
# Variable Definitions
# - - - - - - - - - - - - - - - - - - - -
# File Extensions
srcExt=$1
destExt=$2

# Directory Locations
srcDir=$3
destDir=$4

# FFMPEG Options
opts=$5

# - - - - - - - - - - - - - - - - - - - -
# Variable Definitions
# - - - - - - - - - - - - - - - - - - - -
for filename in "$srcDir"/*."$srcExt"; do

    basePath=${filename%.*}
    baseName=${basePath##*/}

    ffmpeg -i "$filename" "$opts" "$destDir"/"$baseName"."$destExt"

done

echo "Conversion from ${srcExt} to ${destExt} complete!"

# mkdir encoded
# for f in *.mp4; do
#     ffmpeg -i "$f" -c:v libx264 -crf 23 -preset medium -c:a copy -movflags +faststart "encoded/${f%.*}.mp4";
# done;

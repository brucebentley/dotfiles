#!/usr/bin/env bash

#
# Batch Conversions Using ffmpeg
#
# @USAGE:
#
#     ffmpeg-batch.sh $srcExt $destExt $srcDir $destDir "$opts"
#
# @EXAMPLE:
#
#     ffmpeg-batch.sh flac mp3 ~/Music/'Led Zeppelin' ~/Music/'Led Zeppelin MP3'/ "-ab 320k -loglevel error"
#

usage() { echo "Usage: $0 srcExt destExt srcDir destDir \"[opts]\"" 1>&2; exit 1; }


#
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Variable Definitions
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# File Extensions
srcExt=$1
destExt=$2

# Directory Locations
srcDir=$3
destDir=$4

# ffmpeg Options
opts=$5

find . -type f -name "*.$srcExt" -exec bash -c 'ffmpeg -i "$srcDir"/"$1" $opts "${1/$srcExt/$destExt}"' -- {} \;
# Step 1 - Strip Off The Extension And Assign That To A New Variable.
for file in "$srcDir"/*."$srcExt"; do

    basePath=${file%.*}
    # Step 2 - Strip The Path Off Of The File Name.
    baseName=${basePath##*/}

    # Step 3 - Echo The Result To See What You'Re Getting. It Should Just Be The File Name Itself.
    echo "Converting File: $baseName from $srcExt ⟶ $destExt";

    # Step 4 - Give ffmpeg The Full Filename With The Path As Its Input. Construct The Output
    #          Using The Destination Directory, The Stripped Down Filename & Destination File
    #          Extenstion. Include Your Options In Between. The Quotes Are Required For Bash
    #          To Treat Each Variable As A String.
    ffmpeg -i "$file" $opts "$destDir"/"$baseName"."$destExt";

done

# Step 5 - Display A Message After The Loop, Confirming That The Files Were Successfully Converted.
echo "Conversion from ${srcExt} to ${destExt} complete!"

#
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# This Works!
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# mkdir encoded
# for f in *.mp4; do
#     ffmpeg -i "$f" -c:v libx264 -crf 23 -preset medium -c:a copy -movflags +faststart "encoded/${f%.*}.mp4";
# done;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# find . -type f -name '*.mp3' -exec bash -c 'ffmpeg -i "$1" -c:a aac -b:a 192k ../"${1/mp3/m4a}"' -- {} \;

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# for f in *.mp3; do ffmpeg -i "$f" -c:a aac -b:a 192k m4a/"${f%.mp3}.m4a"; done


find . -name '*.mp3' -type f -exec bash -c 'base64 "$0" > "${0%.mp3}.txt"' {} \;

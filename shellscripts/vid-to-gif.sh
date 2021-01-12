#!/usr/bin/env bash

#
# ffmpeg + ImageMagick. Convert video to GIF by using Terminal.app in macOS
# Link: https://bbentley.link/ffmpeg-ImageMagick-Convert-video-to-GIF-using-Terminal
#

# Usage Function, Displays Valid Arguments
usage() { echo "Usage: $0 [-f <fps, defaults to 15>] [-w <width, defaults to 480] inputfile" 1>&2; exit 1; }

# Default Variables
#fps=15
fps=15
#width=480
width=1080

# getopts To Process The Command Line Arguments
while getopts ":f:w:" opt; do
    case "${opt}" in
        f) fps=${OPTARG};;
        w) width=${OPTARG};;
        *) usage;;
    esac
done

# Shift Out The Arguments Already Processed With getopts
shift "$((OPTIND - 1))"
if (( $# == 0 )); then
    printf >&2 'Missing input file\n'
    usage >&2
fi

# Set Input Variable To The First Option After The Arguments
input="$1"

# Extract Filename From Input File Without The Extension
filename=$(basename "$input")
#extension="${filename##*.}"
filename="${filename%.*}.gif"

# Debug Display To Show What The Script Is Using As Inputs
echo "Input: $#"
echo "Output: $filename"
echo "FPS: $fps"
echo "Width: $width"

# Temporary File To Store The First Pass Pallete
palette="/tmp/palette.png"

# Options To Pass To ffmpeg
filters="fps=$fps,scale=$width:-1:flags=lanczos"

# ffmpeg - First Pass
ffmpeg -v warning -i "$input" -vf "$filters,palettegen" -y $palette
# ffmpeg - Second Pass
ffmpeg -v warning -i "$input" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=3" -y "$filename"

# Display Output File Size
filesize=$(du -h "$filename" | cut -f1)
echo "Output File Name: $filename"
echo "Output File Size: $filesize"

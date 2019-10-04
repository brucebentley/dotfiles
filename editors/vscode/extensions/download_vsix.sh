#!/usr/bin/env bash

REGEX='^([_0-9a-zA-Z\-]+)\.([_0-9a-zA-Z\-]+)'

if [[ -z "$1" ]]; then
    list_file=`realpath "extensions.txt"`
else
    list_file=`realpath "$1"`
fi
if [ -f $list_file ]; then
    echo "File $list_file exists."
else
    echo "File $list_file does not exist."
    return
fi

[[ -z "$2" ]] && output_dir="$(pwd)/plugins" || output_dir="$2"
mkdir -p ${output_dir}

while read extension_line; do
    echo "$extension_line"
    if [[ $extension_line =~ $REGEX ]]
    then
        publisher=${BASH_REMATCH[1]}
        extension=${BASH_REMATCH[2]}
        version="latest"
        echo "Downloading: $publisher.$extension"
        url="https://${publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${extension}/${version}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
        output="${output_dir}/${publisher}.${extension}.vsix"
        curl -o "${output}" ${url}
    else
        echo "Something wrong!"
    fi
done < $list_file

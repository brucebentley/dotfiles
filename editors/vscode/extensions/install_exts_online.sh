#!/usr/bin/env bash

REGEX='^([_0-9a-zA-Z\-]+)\.([_0-9a-zA-Z\-]+)'

if [[ -z "$1" ]]; then
    list_file=$(realpath "extensions.txt")
else
    list_file=$(realpath "$1")
fi
if [ -f "${list_file}" ]; then
    echo "The file ${list_file} exists."
else
    echo "The file ${list_file} does not exist."
    echo "Exporting your currently installed extensions to ${list_file}."
    code --list-extensions > "${list_file}"
    return
fi


while read -r extension_line; do
    echo "${extension_line}"
    if [[ $extension_line =~ $REGEX ]]
    then
        echo "Installing ${extension_line}"
        code --install-extension "${extension_line}"
    else
        echo "Something went wrong!"
    fi
done < "${list_file}"

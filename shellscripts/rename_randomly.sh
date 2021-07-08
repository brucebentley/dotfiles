#!/usr/bin/env bash

chars=( {a..z} {A..Z} {0..9} )

function rand_string {
    local c=$1 ret=
    while((c--)); do
        ret+=${chars[$((RANDOM%${#chars[@]}))]}
    done
    printf '%s\n' "$ret"
}

cd "$1" || exit
for file in ./*;
do
    ext=$(echo ${file} | sed -e 's,^.*\(\.[^\.]*$\),\1,')
    mv "$file" "$(rand_string 12)""${ext}"
done

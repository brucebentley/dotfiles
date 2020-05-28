#!/usr/bin/env bash

# shopt -s extglob
# shopt -s globstar
# shopt -s nullglob
# tree .

# dirs=( */ )
# for f in **/*.*
# do
#     dir="${f%.*}"
#     mkdir -p "$dir"
#     mv "$f" "$dir"
# done

# tree .

# i=0
# for d in **/
# do
    # files=("$d"/*.*)
#     [[ ${#files[@]} -eq 0 ]] && continue
#     (( ++i ))
#     for f in "${files[@]}"
#     do
#         mv -v "$f" $i-${f##*/}
#     done
# done
# rm -r */
# tree .

# a=1
# for i in *.jpg; do
#   new=$(printf "%04d.jpg" "$a")  # 04 Pad To Length Of 4
#   mv -i -- "$i" "$new"
#   (( a=a+1 ));
# done


counter=0
for file in *; do
    [[ -f $file ]] && echo mv -i "$file" $(( counter+1 )).png && (( counter++ ))
done

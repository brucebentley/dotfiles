#!/usr/bin/env zsh

#
# Note:
# There Is One Command-Line Argument Of Input Followed By Converted Filenames
# Count Of All Input And Output Files
#
typeset -i max=$#
typeset -i idx=0
let "idx = $# / 2"

# Temporary Array Of Combined Input And Converted Image Names
typeset -a temp=($@)

# Slice Temp Array To Get File Categories. Zsh Arrays Are 1 Based.
typeset -a input_images=("${(@)temp[1,idx]}")
let "idx++"
typeset -a convert_images=("${(@)temp[idx,max]}")

# Now Perform Nested Array Comparison
for i in "${(@)input_images}";
do
    for c in "${(@)convert_images}";
    do
        # Compare Input And Converted Basenames
        [[ ! $i:t:r == $c:t:r ]] && continue
            # Names Match So Borrow Creation/Modication Date
            # From Input Filename And Apply To Output File.
            /usr/bin/touch -r $i $c
            # Get Another Input Filename
            break
    done
done

# Print Appended Listing Of Input And Converted Filenames If Arrays Are Non-Zero In Size
{ [ "${input_images[@]}" -eq 0 ] || printf 'input_images = %s\n' "${(@)input_images}";} >> ~/Desktop/foo.txt
{ [ "${convert_images[@]}" -eq 0 ] || printf 'converted_images = %s\n' "${(@)convert_images}";} >> ~/Desktop/foo.txt

exit 0

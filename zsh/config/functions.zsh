################################################################################
#                                                                              #
# FUNCTIONS                                                                    #
#                                                                              #
################################################################################

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: General
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# Label: Colorized Type
# Description: Identical to "type" system command but with Bat support.
# Parameters: $1 (required) - The alias or function to inspect source code for.
cype() {
  local name="$1"

  if [[ -n "$name" ]]; then
    type "$name" | cat --language "bash"
  fi
}

# Label: Environment Update
# Description: Update environment with latest software.
eup() {
  hbsu
  gemuc
  rustup update
  docker system prune --force
  docker buildx prune --force

  (
    cd $HOME/Engineering/OSS
    bca
    bua
    gvaca
  )
}

# Label: ISO
# Description: Builds an ISO image from mounted volume.
# Parameters: $1 (required) - Volume source path. $2 (required) - ISO output file path.
iso() {
  local source_path="$1"
  local output_path="$HOME/Downloads/$2.iso"

  if [[ ! -d "$source_path" ]]; then
    printf "%s\n" "Source path must be supplied or doesn't exist: $source_path."
    return 1
  fi

  if [[ -z "$2" ]]; then
    printf "%s\n" "ISO file name must be supplied."
    return 1
  fi

  printf "%s\n" "Creating $output_path..."
  hdiutil makehybrid -iso -joliet -o "$output_path" "$source_path"
}

# Label: Kill Process
# Description: Kill errant/undesired process.
# Parameters: $1 (required) - The search query, $2 (optional) - The signal. Default: 15.
kilp() {
  local query="$1"
  local signal=${2:-15}

  pkill -$signal -l -f "$query"
}

# Label: Tab to Space
# Description: Convert file from tab to space indendation.
# Parameters: $1 (required) - File path, $2 (optional) - Number of spaces, default: 2.
t2s() {
  local number_of_spaces="${2:-2}"

  if [[ "$1" ]]; then
    local temp_file=$(mktemp -t tabs_to_spaces) || { printf "\n%s\n" "ERROR: Unable to create temporary file."; return; }
    expand -t $number_of_spaces "$1" > $temp_file
    cat $temp_file > "$1"
    printf "%s\n" "Converted: $1."
    rm -f $temp_file;
  else
    printf "%s\n" "ERROR: File must be supplied."
    return 1
  fi
}


# Label: Create Directory
# Description: Create a new directory and enter it
# Parameters:
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# Label: Change Finder Directory
# Description: Change working directory to the top-most finder window location
# Parameters:
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

# Label: Create tar archive
# Description: Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
# Parameters:
function targz() {
    local tmpFile="${@%/}.tar";
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

    size=$(
        stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
        stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
    );

    local cmd="";
    if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
        # THE .tar FILE IS SMALLER THAN 50 MB AND ZOPFLI IS AVAILABLE; USE IT.
        cmd="zopfli";
    else
        if hash pigz 2> /dev/null; then
            cmd="pigz";
        else
            cmd="gzip";
        fi;
    fi;

    echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
    "${cmd}" -v "${tmpFile}" || return 1;
    [ -f "${tmpFile}" ] && rm "${tmpFile}";

    zippedSize=$(
        stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
        stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
    );

    echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Label: File & Directory Sizes
# Description: Determine size of a file or total size of a directory
# Parameters:
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}

# Label: Git Diff
# Description: Use git’s colored diff when available
# Parameters:
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

# Label: Data URL
# Description: Create a data url from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Label: git.io
# Description: Create a git.io short url
# Parameters:
function gitio() {
    if [ -z "${1}" -o -z "${2}" ]; then
        echo "Usage: \`gitio slug url\`";
        return 1;
    fi;
    curl -i https://git.io/ -F "url=${2}" -F "code=${1}";
}

# Label: Simple Python Server
# Description: Start an http server from a directory, optionally specifying the port
# Parameters:
#function server() {
#    local port="${1:-8000}";
#    sleep 1 && open "http://localhost:${port}/" &
#    # SET THE DEFAULT CONTENT-TYPE TO `text/plain` INSTEAD OF `application/octet-stream`
#    # AND SERVE EVERYTHING AS UTF-8 (ALTHOUGH NOT TECHNICALLY CORRECT, THIS DOESN’T BREAK ANYTHING FOR BINARY FILES)
#    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
#}

# Label: Python Server with SSL
# Description: Start an http server from a directory, optionally specifying the port
# Parameters:
function server() {
    local currentDir="${PWD##*/}";
    local localhostname
    localhostname="${1:-${currentDir}}";
    local port
    port="${2:-4443}";
    local certpath
    certpath="${3:-${HOME}/workspace/Personal/certs/local-cert.pem}";
    local keypath
    keypath="${3:-${HOME}/workspace/Personal/certs/local-key.pem}";

    sleep 1 && open "https://${localhostname}.dev.local:${port}/" &

    # SET THE DEFAULT CONTENT-TYPE TO `text/plain` INSTEAD OF `application/octet-stream`
    # AND SERVE EVERYTHING AS UTF-8 (ALTHOUGH NOT TECHNICALLY CORRECT, THIS DOESN’T BREAK ANYTHING FOR BINARY FILES)
    python "${HOME}"/dotfiles/shellscripts/python/simple-server.py "${localhostname}" "${port}" "${certpath}" "${keypath}";
}

# Label: Simple PHP Server
# Description: Start a php server from a directory, optionally specifying the port. ( REQUIRES PHP 5.4.0+ )
# Parameters:
function phpserver() {
    local port="${1:-4000}";
    local ip=$(ipconfig getifaddr en1);
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}";
}

# Label: Compare gzipped Files
# Description: Compare original and gzipped file size
# Parameters:
function gz() {
    local origsize=$(wc -c < "$1");
    local gzipsize=$(gzip -c "$1" | wc -c);
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
    printf "orig: %d bytes\n" "$origsize";
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Label: JSON Syntax Highlighting
# Description: Syntax-highlight json strings or files
# Parameters:
#
# @usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
        python -mjson.tool | pygmentize -l javascript;
    fi;
}

# Label: dig DNS Lookup
# Description: Run `dig` and display the most useful info
# Parameters:
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

# Label: Encode Unicode
# Description: UTF-8-encode a string of unicode symbols
# Parameters:
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Label: Decode Unicode
# Description: Decode \x{abcd}-style unicode escape sequences
# Parameters:
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Label: Unicode Characters
# Description: Get a character’s unicode code point
# Parameters:
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Label: Get SSL certificate(s)
# Description: SHOW ALL THE NAMES (CNS AND SANS) LISTED IN THE SSL CERTIFICATE FOR A GIVEN DOMAIN.
# Parameters:
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}…";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version");
        echo "Common Name:";
        echo ""; # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
        echo ""; # newline
        echo "Subject Alternative Name(s):";
        echo ""; # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
        return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}

# Label: Open in Sublime Text
# Description: `s` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN SUBLIME TEXT, OTHERWISE OPENS THE GIVEN LOCATION.
# Parameters:
function s() {
    if [ $# -eq 0 ]; then
        subl -n .;
    else
        subl -n "$@";
    fi;
}

# Label: Open in Visual Studio Code
# Description: `a` wITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN VS CODE EDITOR, OTHERWISE OPENS THE GIVEN LOCATION.
# Parameters:
function vs() {
    if [ $# -eq 0 ]; then
        code-insiders -n .;
    else
        code-insiders -n "$@";
    fi;
}

# Label: Open in VIM
# Description: `v` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN VIM, OTHERWISE OPENS THE GIVEN LOCATION.
# Parameters:
function v() {
    if [ $# -eq 0 ]; then
        vim .;
    else
        vim "$@";
    fi;
}

# Label: Open Current Directory
#`Description: o` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY, OTHERWISE OPENS THE GIVEN LOCATION.
# Parameters:
function o() {
    if [ $# -eq 0 ]; then
        open .;
    else
        open "$@";
    fi;
}

# Label: Tree Directory Browsing
# Description: `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
#               the `.git` directory, listing directories first. the output gets piped into
#              `less` with options to preserve color and line numbers, unless the output is
#               small enough for one screen.
# Parameters:
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Label: Extract Archives
# Description: Always use the correct program to extract files
# Parameters:
function extract {
    if [ -z "$1" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${violet}@USAGE:${reset}\n${yellow}extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>${reset}"
        echo
    else
        if [ -f $1 ] ; then
            # NAME=${1%.*}
            # mkdir $NAME && cd $NAME
            case $1 in
                *.tar.bz2)   tar xvjf ./$1    ;;
                *.tar.gz)    tar xvzf ./$1    ;;
                *.tar.xz)    tar xvJf ./$1    ;;
                *.lzma)      unlzma ./$1      ;;
                *.bz2)       bunzip2 ./$1     ;;
                *.rar)       unrar x -ad ./$1 ;;
                *.gz)        gunzip ./$1      ;;
                *.tar)       tar xvf ./$1     ;;
                *.tbz2)      tar xvjf ./$1    ;;
                *.tgz)       tar xvzf ./$1    ;;
                *.zip)       unzip ./$1       ;;
                *.Z)         uncompress ./$1  ;;
                *.7z)        7z x ./$1        ;;
                *.xz)        unxz ./$1        ;;
                *.exe)       cabextract ./$1  ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

# Label: Bookmark Manager
# Description: Create & manage bookmark shortcuts
# Parameters: $1 (required) - The defined bookmark string.
function b() {
    # Bookmarks
    local -A bookmarks=(
        'e' '~/Desktop/'
        'd' '~/Documents/'
        'w' '~/Downloads/'
        'i' '~/Pictures/'
        'p' '~/Projects/'
        'v' '~/Videos/'
    )

    local selected_bookmark

    if [[ "$1" != '' ]] {
        selected_bookmark="${bookmarks[$1]}"
    } else {
        local bookmarks_table

        local key
        foreach key (${(k)bookmarks}) {
            bookmarks_table+="$key ${bookmarks[$key]}\n"
        }

        if (! hash fzf &>/dev/null) {
            return 1
        } else {
            selected_bookmark=$(
                printf "$bookmarks_table" \
                | fzf \
                    --exact \
                    --height='30%' \
                    --preview='eval ls -l --si --almost-all --classify --color=always --group-directories-first --literal {2} 2>/dev/null' \
                    --preview-window='right:60%' \
            )

            selected_bookmark="${selected_bookmark[(ws: :)2]}"
        }
    }

    if [[ "$selected_bookmark" != '' ]] {
        eval cd "$selected_bookmark"
    } else {
        return 1
    }
}

# Label: Hex Convert
# Description: Convert hex color value to a (nearest) 0-256 color index
# Parameters:
function fromhex() {
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Docker
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Docker SSH
# Description: Connect to a specified docker container
# Parameters:
dockerssh() {
    if [ -z "${1}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\n${fgYellow}dockerssh <container_id>${reset}"
        echo
    else
        dockerexec $1 /bin/bash
    fi
}

# Label: Docker Exec
# Description: Execute commands inside a specified docker container
# Parameters:
dockerexec() {
    if [ -z "${1}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\n${fgYellow}dockerexec <container_id> <command>${reset}"
        echo
    else
        sudo docker exec -i -t $1 $2
    fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: ffmpeg
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Download Protected Streams
# Description: Download protected streaming videos using their `m3u8` playlist chunks.
# Parameters:
ffmpeg-dl() {
    if [ -z "${1}" -o -z "${2}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\t\`${fgYellow}ffmpeg-dl input-url output-file${reset}\`";
        echo -en "${bold}${fgViolet}@EXAMPLE:${reset}\t\`${fgYellow}ffmpeg-dl http://example.com/video_url.m3u8 output.mp4${reset}\`";
        return 1;
    fi;
    ffmpeg -i "${1}" -c copy -bsf:a aac_adtstoasc "${2}.mp4";
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: ZSH
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Cache Binary Initialization Command Output
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# This helps to avoid the time to execute it in the future.
#
# @usage: `_evalcache <command> <generation args...>`
# Source: https://github.com/mroth/evalcache
function _evalcache () {
    local cacheFile="$ZSH_EVALCACHE_DIR/init-${1##*/}.sh"

    if [ "$ZSH_EVALCACHE_DISABLE" = "true" ]; then
        eval "$("$@")"
    elif [ -s "$cacheFile" ]; then
        source "$cacheFile"
    else
        if type "$1" > /dev/null; then
            (>&2 echo "$1 initialization not cached, caching output of: $*")
            mkdir -p "$ZSH_EVALCACHE_DIR"
            "$@" > "$cacheFile"
            source "$cacheFile"
        else
            echo "evalcache ERROR: $1 is not installed or in PATH"
        fi
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Benchmarks The Current $SHELL
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function bench_shell() {
    for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: ASCII Doctor - [https://asciidoctor.or]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: ASCII Doctor Open
# Description: Transforms ASCII Doc into HTML and opens in default browser.
# Parameters: $1 (required) - Path to ASCII Doc source file.
ado() {
  local input="$1"
  local output=$(mktemp -t asciidoc)

  asciidoctor --failure-level WARN --out-file "$output" "$input"
  open "$output" -a "Firefox.app"
  read -p "Viewing: $output. Use any key to continue. " response
  rm -f "$output"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: asciinema  - [https://asciinema.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: asciinema Record
# Description: Create new asciinema recording.
# Parameters: $1 (required) - The recording label.
cinr() {
  local label="$1"
  local name="${label,,}.cast"

  if [[ -z "$label" ]]; then
    printf "%s\n" "ERROR: Recording label is missing."
    return 1
  fi

  asciinema rec --title "$label" "$name"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Bundler  - [https://bundler.io]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Bundler Clean (all)
# Description: Clean projects of gem artifacts (i.e. pkg folder).
bca() {
  while read -r project; do
    (
      cd "$project"
      if [[ -f "Gemfile.lock" ]]; then
        printf "\033[36m${project}\033[m: " # Outputs project in cyan color.

        # Print status if found, otherwise a checkmark for passing status.
        if [[ $(rg --files --glob *.gem | wc -l | xargs) > 0 ]]; then
          rm -f *.gem
          rm -rf pkg
          printf "%s\n" "Cleaned gem artifacts."
        else
          printf "✓\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Bundler Config Gem
# Description: Configure Bundler to use local gem for development purposes.
# Parameters: $1 (required) - Gem name, $2 (required) - Gem path.
bcg() {
  local gem_name=$1
  local gem_path=$2

  if [[ -z "$gem_name" ]]; then
    printf "%s\n" "ERROR: Gem name must be supplied!"
    return 1
  fi

  if [[ -z "$gem_path" ]]; then
    printf "%s\n" "ERROR: Gem path must be supplied!"
    return 1
  fi

  bundle config "local.$gem_name" "$gem_path"
  printf "%s\n" "Added: $(tail -n 1 $HOME/.bundle/config)"
}

# Label: Bundler Jobs
# Description: Answer maximum Bundler job limit for current machine or automatically set it.
bj() {
  if command -v sysctl > /dev/null; then
    local computer_name=$(scutil --get ComputerName)
    local max_jobs=$((`sysctl -n hw.ncpu` - 1))
    local bundler_config="$HOME/.bundle/config"

    printf "%s\n" "$computer_name's maximum Bundler job limit is: $max_jobs."

    if command -v rg > /dev/null && [[ -e "$bundler_config" ]]; then
      local current_jobs=$(rg "JOBS" $bundler_config | awk '{print $2}' | tr -d "'")

      if [[ $current_jobs != $max_jobs ]]; then
        bundle config --global jobs $max_jobs
        printf "%s\n" "Automatically updated Bundler to use maximum job limit. Details: $bundler_config."
      else
        printf "%s\n" "$computer_name is using maximum job limit. Kudos!"
      fi
    fi
  else
    printf "ERROR: Operating system must be OSX."
    return 1
  fi
}

# Label: Bundle List
# Description: List gem dependencies for project and copy them to clipboard.
bl() {
  local collection=()

  printf "%s\n" "Calculating gem dependencies (will be copied to clipboard)..."

  for gem in $(bundle list --name-only); do
    collection+=("$(bundle info "$gem")")
  done

  printf "%s\n" "${collection[@]}" | pbcopy && pbpaste
}

# Label: Bundle Outdated (all)
# Description: Answer outdated gems for projects in current directory.
boa() {
  while read -r project; do
    (
      cd "$project"

      if [[ -f "Gemfile.lock" ]]; then
        printf "\033[36m${project}\033[m: " # Outputs project in cyan color.

        # Capture current project status: Search for bullets (*, outdated gems) or missing (not found) gems.
        local results=$(bundle outdated | rg --only-matching "(\*.+|.+not\sfind.+)")

        # Print project status if Bundler activity is detected, otherwise a checkmark for passing status.
        if [[ -n "$results" ]]; then
          printf "\n%s\n" "$results"
        else
          printf "✓\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Bundle Update (all)
# Description: Update gems for projects in current directory.
bua() {
  while read -r project; do
    (
      cd "$project"
      if [[ -f "Gemfile.lock" ]]; then
        rm -f Gemfile.lock
        bundle install --quiet

        # Print project status if Bundler activity is detected, otherwise a checkmark for passing status.
        printf "\033[36m${project}\033[m: " # Outputs project in cyan color.
        if [[ $(git diff | wc -l | tr -d ' ') -gt 0 ]]; then
          printf "↑\n"
        else
          printf "✓\n"
        fi
      fi
    )
  done < <(ls -A1)
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Code Quality - [https://www.alchemists.io/projects/code_quality]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Code Quality (all)
# Description: Run code quality tasks for projects in current directory.
cqa() {
  while read -r project; do
    (
      cd "$project"
      if [[ -f "Gemfile.lock" && -f "Rakefile" ]]; then
        # Prints project (cyan).
        printf "\033[36m${project}\033[m:\n"

        rake code_quality
        printf "\n"
      fi
    )
  done < <(ls -A1)
}

# Label: Code Quality Issues
# Description: List all source files affected by code quality issues.
cqi() {
  local comments=("TODO" "FIX" "DUPLICATE" "shellcheck disable" ":reek:" "rubocop:disable")

  for comment in ${comments[*]}; do
    rg --case-sensitive --iglob '!vendor' --regexp "^\s*?(#|--|//) $comment" .
  done
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: curl - [https://curl.se]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Curl Diagnostics
# Description: Curl with diagnostic information for request.
# Parameters: $1 (required) - The URL.
curld() {
  local url="$1"

  printf -v diagnostics "%s\n" "\n" \
                               "HTTP Version:   %{http_version}" \
                               "HTTP Status:    %{http_code}" \
                               "Content Type:   %{content_type}" \
                               "DNS Lookup:     %{time_namelookup} seconds" \
                               "Connect:        %{time_connect} seconds" \
                               "App Connect:    %{time_appconnect} seconds" \
                               "Pre-Transfer:   %{time_pretransfer} seconds" \
                               "Start Transfer: %{time_starttransfer} seconds" \
                               "Speed:          %{speed_upload}↑ %{speed_download}↓ bytes/second" \
                               "Total Time:     %{time_total} seconds" \
                               "Total Size:     %{size_download} bytes"

  curl --write-out "$diagnostics" --url "$url"
}

# Label: Curl Inspect
# Description: Inspect remote file with default editor.
# Parameters: $1 (required) - The URL.
curli() {
  if [[ "$1" ]]; then
    local file=$(mktemp -t suspicious_curl_file) || { printf "%s\n" "ERROR: Unable to create temporary file."; return; }
    curl --location --fail --silent --show-error "$1" > $file || { printf "%s\n" "Failed to curl file."; return; }
    $EDITOR --wait $file || { printf "Unable to open temporary curl file.\n"; return; }
    rm -f $file;
  else
    printf "%s\n" "ERROR: URL must be supplied."
    return 1
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Dotfiles
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Dotfiles
# Description: Learn about dotfile aliases, functions, etc.
# Parameters: $1 (optional) - The option selection, $2 (optional) - The option input.
dots() {
  while true; do
    if [[ $# == 0 ]]; then
      printf "\n%s\n" "Usage: dots OPTION"
      printf "\n%s\n" "Dotfile Options:"
      printf "  %s\n" "a: Print aliases."
      printf "  %s\n" "f: Print functions."
      printf "  %s\n" "g: Print Git hooks."
      printf "  %s\n" "p: Print all."
      printf "  %s\n" "s: Search for alias/function."
      printf "  %s\n\n" "q: Quit/Exit."
      read -r -p "Enter selection: " response
      printf "\n"
      _process_dots_option $response "$2"
    else
      _process_dots_option $1 "$2"
    fi
    break
  done
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Elm  - [https://elm-lang.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Elm Live
# Description: Watch for source code changes and recompile immediately.
# Parameters: $1 (required) - The source path, $2 (optional) - The output path.
elml() {
  local source_path="$1"
  local output_path="${2:-/dev/null}"

  if [[ -z "$source_path" || -z "$output_path" ]]; then
    printf "%s\n" "ERROR: Source and output path must be provided."
    return 1
  fi

  elm-live "$source_path" --debug --output="$output_path"
}

# Label: Elm Make
# Description: Compile Elm source.
# Parameters: $1 (required) - The source path, $2 (required) - The output path.
elmm() {
  local source_path="$1"
  local output_path="$2"

  if [[ -z "$source_path" || -z "$output_path" ]]; then
    printf "%s\n" "ERROR: Source and output path must be provided."
    return 1
  fi

  elm make "$source_path" --optimize --output="$output_path"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: General
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -







# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Git  - [https://git-scm.com]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Git Safe
# Description: Marks repository as safe for auto-loading project's `bin` path.
gafe() {
  if [[ -d ".git" ]]; then
    mkdir -p .git/safe
    printf "%s\n" "Repository has been marked safe."
    exec "$HOMEBREW_PREFIX/bin/bash"
  fi
}

# Label: Git Add (all)
# Description: Apply file changes (including new files) for projects in current directory.
galla() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Apply all changes to Git.
        local results=$(git add --verbose --all .)

        # Print project name (cyan) and Git activity (white) only if Git activity was detected.
        if [[ -n "$results" ]]; then
          printf "\033[36m${project}\033[m:\n$results\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Stash
# Description: Creates stash.
# Parameters: $1 (optional) - Label. Default: "Last Actions (YYYY-MM-DD HH:MM:SS AM|PM Z)."
gash() {
  local label=${1:-"Last Actions ($(date '+%Y-%m-%d %r %Z'))."}
  git stash push --include-untracked --message "$label"
}

# Label: Git Stash (all)
# Description: Answer stash count for projects in current directory.
gasha() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        local count=$(_git_stash_count)

        if [[ -n $count && $count != 0 ]]; then
          printf "\033[36m${project}\033[m: $count\n" # Outputs in cyan color.
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Stash Drop
# Description: Drop stash or prompt for stash to drop.
gashd() {
  _process_git_stash "git stash drop" "Git Stash Drop Options (select stash to drop)"
}

# Label: Git Stash List
# Description: List stashes.
gashl() {
  git stash list --pretty=format:'%C(magenta)%gd%C(reset) %C(yellow)%h%C(reset) %s %C(green)(%cr)%C(reset)'
}

# Label: Git Stash Pop
# Description: Pop stash or prompt for stash to pop.
gashp() {
  _process_git_stash "git stash pop" "Git Stash Pop Options (select stash to pop)"
}

# Label: Git Stash Show
# Description: Show stash or prompt for stash to show.
# Parameters: $1 (optional) - Show git diff. Default: skipped.
gashs() {
  local stash=($(git stash list))
  local diff_option="$1"

  if [[ -n "$diff_option" ]]; then
    case "$diff_option" in
      'd')
        _process_git_stash "git stash show --patch" "Git Stash Diff Options (select stash to diff)";;
      't')
        _process_git_stash "git difftool" "Git Stash Diff Options (select stash to diff)";;
      *)
        printf "%s\n\n" "Usage: gashs OPTION"
        printf "%s\n" "Available options:"
        printf "%s\n" "  d: Git diff."
        printf "%s\n" "  t: Git difftool."
        return;;
    esac
  else
    _process_git_stash "_git_show_details" "Git Stash Show Options (select stash to show)"
  fi
}

# Label: Git Branch Create
# Description: Create and switch to branch.
# Parameters: $1 (required) - New branch name.
gbc() {
  local name="$1"

  if [[ "$name" ]]; then
    git switch --create "$name" --track
    printf "%s" "$name" | _copy_and_print
  else
    printf "%s\n" "ERROR: Branch name must be supplied."
    return 1
  fi
}

# Label: Git Branch Create (all)
# Description: Create and switch to branch for projects in current directory.
# Parameters: $1 (required) - The branch name.
gbca() {
  local branch="$1"

  if [[ -n "$branch" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          if [[ "$(_git_branch_name)" != "$branch" ]]; then
            git switch --create "$branch" --track
            printf "\033[36m${project}\033[m: $branch\n" # Output in cyan and branch in white color.
          fi
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Branch name must be supplied."
  fi
}

# Label: Git Branch Delete
# Description: Interactively delete local and/or remote branch.
gbd() {
  local branch="$(gbl | fzf | awk '{print $1}')"

  if [[ -n "$branch" ]]; then
    gbdl "$branch"
    gbdr "$branch"
  fi
}

# Label: Git Branch Delete (local)
# Description: Delete local branch.
# Parameters: $1 (required) - Branch name.
gbdl() {
  local branch="$1"

  if [[ -n "$(git branch --list $branch)" ]]; then
    printf "\033[31m" # Red.
    read -p "Delete \"$branch\" local branch (y/n)?: " response
    printf "\033[m" # White.

    if [[ "$response" == 'y' ]]; then
      git branch --delete --force "$branch"
    else
      printf "%s\n" "Local branch deletion aborted."
    fi
  else
    printf "%s\n" "Local branch not found."
  fi
}

# Label: Git Branch Delete (merged)
# Description: Delete remote and local merged branches.
gbdm() {
  if [[ $(_git_branch_name) != "$(_git_branch_default)" ]]; then
    printf "%s\n" "ERROR: Whoa, switch to default branch first."
    return 1
  fi

  # Remote
  git branch --remotes \
             --merged \
             | rg "origin" \
             | rg --invert-match "$(_git_branch_default)" \
             | sed 's/origin\///' \
             | xargs -n 1 git push --delete origin

  # Local
  git branch --merged | rg --invert-match "\* $(_git_branch_default)" | xargs -n 1 git branch --delete --force
}

# Label: Git Branch Delete (remote)
# Description: Delete remote branch.
# Parameters: $1 (required) - Branch name.
gbdr() {
  local branch="$1"

  if [[ -n "$(git branch --remotes --list origin/$branch)" ]]; then
    printf "\033[31m" # Red.
    read -p "Delete \"$branch\" remote branch (y/n)?: " response
    printf "\033[m" # White.

    if [[ "$response" == 'y' ]]; then
      git push --delete origin "$branch"
    else
      printf "%s\n" "Remote branch deletion aborted."
    fi
  else
    printf "%s\n" "Remote branch not found."
  fi
}

# Label: Git Branch Facsimile
# Description: Duplicate current branch with new name and switch to it.
# Parameters: $1 (required) - New branch name.
gbf() {
  local new="$1"
  local old="$(_git_branch_name)"

  if [[ "$new" ]]; then
    git switch --create "$new" "$old" --track
    git commit --allow-empty --no-verify --message "----- End of $old work -----"
  else
    printf "%s\n" "ERROR: Branch name must be supplied."
    return 1
  fi
}

# Label: Git Branch List
# Description: List local and remote branch details.
gbl() {
  local format="%(refname)|%(color:yellow)%(objectname)|%(color:reset)|%(color:blue bold)%(authorname)|%(color:green)|%(committerdate:relative)"

  git for-each-ref --sort="authordate:iso8601" \
                   --sort="authorname" \
                   --color \
                   --format="$format" refs/heads refs/remotes/origin \
                   | sed '/HEAD/d' \
                   | sed 's/refs\/heads\///g' \
                   | sed 's/refs\/remotes\/origin\///g' \
                   | uniq \
                   | sort \
                   | column -s'|' -t
}

# Label: Git Branch List (all)
# Description: List current branch for projects in current directory.
gbla() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        local branch="$(_git_branch_name)"
        printf "\033[36m${project}\033[m: " # Output in cyan color.

        if [[ "$branch" == "$(_git_branch_default)" ]]; then
          printf "%s\n" "$branch"
        else
          printf "\033[31m$branch\033[m\n" # Output in red color.
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Branch List (owner)
# Description: List branches owned by current author or supplied author.
# Parameters: $1 (optional) - The author name.
gblo() {
  local owner="${1:-$(git config user.name)}"
  gbl | rg --color never "$owner"
}

# Label: Git Branch Number (all)
# Description: Answer number of branches for projects in current directory.
gbna() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        local current_branch="$(_git_branch_name)"
        local number="$(gbl | rg --invert-match "$(_git_branch_default)" | wc -l | tr -d ' ')"

        if [[ $number -gt 0 ]]; then
          # Output project in cyan and number in white color.
          printf "\033[36m${project}\033[m: $number\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Branch Rename
# Description: Rename current branch.
# Parameters: $1 (required) - Branch name.
gbr() {
  local new_branch="$1"
  local old_branch="$(_git_branch_name)"

  git branch --track --move "$new_branch"

  if [[ -n "$(git branch --remotes --list origin/$old_branch)" ]]; then
    printf "\033[31m" # Red.
    read -p "Delete \"$old_branch\" remote branch (y/n)?: " response
    printf "\033[m" # White.

    if [[ "$response" == 'y' ]]; then
      git push --delete origin "$old_branch"
    fi
  fi
}

# Label: Git Branch Switch
# Description: Switch between branches.
gbs() {
  gbl | fzf | awk '{print $1}' | xargs git switch
}

# Label: Git Branch Switch (all)
# Description: Switch to given branch for projects in current directory.
# Parameters: $1 (required) - The branch name.
gbsa() {
  local branch="$1"

  if [[ -n "$branch" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          local current_branch="$(_git_branch_name)"

          if [[ $(git rev-parse --quiet --verify "$branch") && "$current_branch" != "$branch" ]]; then
            git switch --quiet "$branch"
            printf "\033[36m${project}\033[m: $branch\n" # Output in cyan and branch in white color.
          fi
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Branch name must be supplied."
  fi
}

# Label: Git Commit (all)
# Description: Commit changes (unstaged and staged) for projects in current directory.
gcaa() {
  local temp_file=$(mktemp -t git-commit)
  cp $HOME/.config/git/commit_message.txt $temp_file
  $EDITOR --wait $temp_file

  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Only process projects that have changes.
        if [[ "$(git status --short)" ]]; then
          printf "\033[36m${project}\033[m:\n" # Outputs in cyan color.
          git commit --all --cleanup strip --file $temp_file
        fi
      fi
    )
  done < <(ls -A1)

  rm -f $temp_file
}

# Label: Git Commit and Push (all)
# Description: Commit and push changes for projects in current directory.
gcap() {
  local temp_file=$(mktemp -t git-commit)
  cp $HOME/.config/git/commit_message.txt $temp_file
  $EDITOR --wait $temp_file

  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Only process projects that have changes.
        if [[ "$(git status --short)" ]]; then
          printf "\033[36m${project}\033[m:\n" # Outputs in cyan color.
          git commit --all --cleanup strip --file $temp_file && gp
        fi
      fi
    )
  done < <(ls -A1)

  rm -f $temp_file
}

# Label: Git Commit Breakpoint
# Description: Create a breakpoint (empty) commit to denote related commits in a feature branch.
# Parameters: $1 (optional) - A custom label. Default: "Breakpoint"
gcb() {
  local label="${1:-Breakpoint}"
  git commit --allow-empty --no-verify --message "----- $label -----"
}

# Label: Git Commit Fix (file)
# Description: Create commit fix for file (ignores previous fixups).
# Parameters: $1 (required) - The file to create fixup commit for.
gcff() {
  local file_path="$1"
  local file_sha="$(git log --grep 'fixup!' --invert-grep --pretty=format:%h -1 $file_path)"

  if [[ "($(_git_branch_shas))" == *"$file_sha"* ]]; then
    git add "$file_path" && git commit --fixup "$file_sha"
  fi
}

# Label: Git Commit Fix (interactive)
# Description: Select which commit to fix within current feature branch.
gcfi() {
  local commits=($(_git_branch_shas))

  _git_commit_options "${commits[*]}"

  printf "\n"
  read -p "Enter selection or quit (q): " response
  if [[ "$response" == 'q' ]]; then
    return
  fi

  printf "\n"
  local selected_commit=${commits[$((response - 1))]}
  gcf "$selected_commit"
}

# Label: Git Day
# Description: Answer summarized list of current day activity for projects in current directory.
gday() {
  gince "12am"
}

# Label: Git Reset Hard
# Description: Reset to HEAD, destroying all untracked, staged, and unstaged changes. UNRECOVERABLE!
# Parameters: $1 (optional) - The number of commits to reset or a specific commit SHA.
gesh() {
  local value="$1"
  local number_pattern="^[0-9]+$"
  local commit_pattern="^[a-f0-9]+$"

  git clean --force --quiet -d

  if [[ "$value" =~ $number_pattern ]]; then
    git reset --hard "HEAD~${value}"
  elif [[ "$value" =~ $commit_pattern ]]; then
    git reset --hard "${value}"
  else
    git reset --hard HEAD
  fi
}

# Label: Git Reset Hard (all)
# Description: Destroy all untracked, staged, and unstaged changes for all projects in current directory. UNRECOVERABLE!
# Parameters: $1 (optional) - The number of commits to reset or a specific commit SHA.
gesha() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        printf "\n\033[36m${project}\033[m:\n" # Outputs in cyan color.
        gesh "$1"
      fi
    )
  done < <(ls -A1)
}

# Label: Git Reset Soft
# Description: Resets previous commit (default), resets back to number of commits, or resets to specific commit.
# Parameters: $1 (optional) - The number of commits to reset or a specific commit SHA.
gess() {
  local value="$1"
  local number_pattern="^[0-9]+$"
  local commit_pattern="^[a-f0-9]+$"

  if [[ "$value" =~ $number_pattern ]]; then
    git reset --soft "HEAD~${value}"
  elif [[ "$value" =~ $commit_pattern ]]; then
    git reset --soft "${value}"
  else
    git reset --soft HEAD^
  fi
}

# Label: Git Get Config Value (all)
# Description: Answer key value for projects in current directory.
# Parameters: $1 (required) - The key name.
ggeta() {
  if [[ "$1" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          # Get Git config value for given key.
          local result=$(git config "$1")

          # Print project (cyan).
          printf "\033[36m${project}\033[m: "

          # Print result.
          if [[ -n "$result" ]]; then
            printf "$1 = $result\n" # White
          else
            printf "\033[31mKey not found.\033[m\n" # Red
          fi
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Key must be supplied."
    return 1
  fi
}

# Label: Git Show
# Description: Show commit details with optional diff support.
# Parameters: $1 (optional) - The commit to show. Default: <last commit>, $2 (optional) - Launch difftool. Default: false.
ghow() {
  local commit="$1"
  local difftool="$2"

  if [[ -n "$commit" && -n "$difftool" ]]; then
    _git_show_details "$commit"
    git difftool "$commit^" "$commit"
  elif [[ -n "$commit" && -z "$difftool" ]]; then
    _git_show_details "$commit"
  else
    _git_show_details
  fi
}

# Label: Git Churn
# Description: Answer commit churn for project files (sorted highest to lowest).
ghurn() {
  git log --all \
          --find-renames \
          --find-copies \
          --name-only \
          --format='format:' "$@" \
          | sort \
          | grep --invert-match '^$' \
          | uniq -c \
          | sort \
          | awk '{print $1 "\t" $2}' \
          | sort --general-numeric-sort --reverse \
          | more
}

# Label: Git Init (all)
# Description: Initialize/re-initialize repositories in current directory.
gia() {
  while read -r project; do
    (
      cd "$project"
      if [[ -d ".git" ]]; then
        printf "\033[36m${project}\033[m: " # Print project (cyan) and message (white).
        git init
      fi
    )
  done < <(ls -A1)
}

# Label: Git File
# Description: Show file details for a specific commit (with optional diff support).
# Parameters: $1 (required) - The file, $2 (required) - The commit, $3 (optional) - Launch difftool. Default: false.
gile() {
  local file="$1"
  local commit="$2"
  local diff="$3"

  if [[ -z "$file" ]]; then
    printf "%s\n" "ERROR: File is missing."
    return 1
  fi

  if [[ -z "$commit" ]]; then
    printf "%s\n" "ERROR: Commit SHA is missing."
    return 1
  fi

  git show --stat --pretty=format:"$(_git_log_details_format)" "$commit" -- "$file"

  if [[ -n "$diff" ]]; then
    gdt $commit^! -- "$file"
  fi
}

# Label: Git Since
# Description: Answer summarized list of activity since date/time for projects in current directory.
# Parameters: $1 (required) - The date/time since value, $2 (optional) - The date/time until value, $3 (optional) - The commit author.
gince() {
  if [[ "$1" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          # Capture git log activity.
          local results=$(git log --oneline --color --format="$(_git_log_line_format)" --since "$1" --until "$2" --author "$3" --reverse)
          # Print project name (cyan) and Git activity (white) only if Git activity was detected.
          if [[ -n "$results" ]]; then
            printf "\033[36m${project}:\033[m\n$results\n"
          fi
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Date/time must be supplied."
    return 1
  fi
}

# Label: Git Info
# Description: Print repository overview information.
ginfo() {
  printf "\n%s\n\n" "$(_print_black_on_white ' Local Configuration (.git/config) ')"
  git config --local --list

  printf "\n%s\n\n" "$(_print_black_on_white ' Stashes ')"
  local stashes="$(gashl)"
  if [[ -n "$stashes" ]]; then
    printf "%s\n" "$stashes"
  else
    printf "%s\n" "None."
  fi

  printf "\n%s\n\n" "$(_print_black_on_white ' Branches ')"
  gbl

  printf "\n%s\n\n" "$(_print_black_on_white ' Remote URLs ')"
  git remote --verbose

  printf "\n%s\n\n" "$(_print_black_on_white ' File Churn (Top 25) ')"
  ghurn | head -n 25

  printf "\n%s\n\n" "$(_print_black_on_white ' Commits by Author ')"
  guthors

  printf "\n%s\n\n" "$(_print_black_on_white ' Total Commits ')"
  gount

  printf "\n%s\n\n" "$(_print_black_on_white ' Last Tag ')"
  _git_last_tag_info

  printf "\n%s\n\n" "$(_print_black_on_white ' Last Commit ')"
  git show --decorate --stat

  printf "\n%s\n\n" "$(_print_black_on_white ' Current Status ')"
  git status --short --branch
}

# Label: Git File History
# Description: View file commit history (with optional diff support).
# Parameters: $1 (required) - The file path.
gistory() {
  if [[ -z "$1" ]]; then
    printf "%s\n" "ERROR: File must be supplied."
    return 1
  fi

  local file="$1"
  local commits=($(git rev-list --reverse HEAD -- "$file"))

  _git_file_commits commits[@] "$file"
}

# Label: Git Blame History
# Description: View file commit history for a specific file and/or lines (with optional diff support).
# Parameters: $1 (required) - The file path, $2 (optional) - The file lines (<start>,<end>).
glameh() {
  if [[ -z "$1" ]]; then
    printf "%s\n" "ERROR: File must be supplied."
    return 1
  fi

  local file="$1"
  local lines="$2"
  local commits=($(git blame -s -M -C -C -L "$lines" "$file" | awk '{print $1}' | sort -u))

  _git_file_commits commits[@] "$file"
}

# Label: Git Log Details
# Description: List default or feature branch commit details.
gld() {
  if [[ "$(_git_branch_name)" == "$(_git_branch_default)" ]]; then
    git log --stat --pretty=format:"$(_git_log_details_format)"
    return
  fi

  local commits=($(_git_branch_shas))

  if [[ ${#commits[@]} == 1 ]]; then
    _git_show_details "${commits[0]}"
  else
    git log --stat --pretty=format:"$(_git_log_details_format)" "${commits[-1]}^..${commits[0]}"
  fi
}

# Label: Git Clean (all)
# Description: Clean uncommitted files from all projects in current directory.
gleana() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Only process projects that have untracked changes.
        if [[ "$(git status --untracked-files --short)" ]]; then
          printf "\n\033[36m${project}\033[m:\n" # Outputs in cyan color.
          git clean -d --force
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Clear
# Description: Clear repository for packaging/shipping purposes.
glear() {
  if [[ ! -d .git ]]; then
    printf "%s\n" "ERROR: Project is not a Git repository."
    return 1
  fi

  read -p "Permanently delete/compact repository files? Continue (y/n)?: " response

  if [[ "$response" == "y" ]]; then
    printf "%s\n\n" "Verifying connectivity and validity of the objects in Git repository..."
    git fsck

    printf "%s\n\n" "Pruning rerere records of older conflicting merges..."
    git rerere gc

    printf "\n%s\n\n" "Aggressively pruning repository..."
    git gc --aggressive --prune=now

    printf "\n%s\n" "Clearing reflog..."
    git reflog expire --expire=now --all

    printf "\n%s\n" "Clearing commit message file..."
    echo > .git/COMMIT_EDITMSG

    printf "\n%s\n" "Clearing sample Git Hooks..."
    rm -rf .git/hooks/*.sample

    printf "\n%s\n" "Deleting code coverage reports..."
    rm -rf coverage

    printf "\n%s\n" "Deleting Rubocop cache..."
    copd

    printf "\n%s\n" "Deleting Node modules..."
    rm -rf node_modules

    printf "\n%s\n" "Deleting Elm packages..."
    rm -rf elm-stuff

    printf "\n%s\n" "Deleting temp directory..."
    rm -rf tmp
  else
    printf "%s\n" "Git clear aborted."
  fi
}

# Label: Git Log (interactive)
# Description: List default or feature branch commits with commit show and/or diff support.
gli() {
  local commits=($(_git_branch_shas))

  _git_commit_options "${commits[*]}"

  printf "\n"
  read -p "Enter selection or quit (q): " response
  if [[ "$response" == 'q' ]]; then
    return
  fi

  local selected_commit=${commits[$((response - 1))]}
  printf "%s\n" "$(_git_show_details $selected_commit)"

  printf "\n"
  read -p "View diff (y = yes, n = no)? " response
  if [[ "$response" == 'y' ]]; then
    gdt $selected_commit^!
  fi
}

# Label: Git Merge (all)
# Description: Merges, deletes, and pushes feature branch.
# Parameters: $1 (required) - Branch.
gma() {
  local branch="$1"

  if [[ -z "$branch" ]]; then
    printf "%s\n" "ERROR: Branch must be supplied."
    return 1
  fi

  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" && "$(_git_branch_name)" == "$branch" ]]; then
        printf "\033[36m${project}\033[m: Merging, deleting, and pushing...\n"

        git switch "$(_git_branch_default)" \
        && git merge "$branch" \
        && git branch --delete --force "$branch" \
        && git push --delete origin "$branch" \
        && git push
      fi
    )
  done < <(ls -A1)
}

# Label: Git Month
# Description: Answer summarized list of current month activity for projects in current directory.
gmonth() {
  gince "1 month 12am"
}

# Label: Git Amend Push (all)
# Description: Amend all changes and force push with lease for projects in current directory.
gmpa() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Only process projects that have changes.
        if [[ "$(git status --short)" ]]; then
          printf "\033[36m${project}\033[m:\n" # Outputs in cyan color.
          git commit --amend --all --no-edit && git push --force-with-lease
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Commit Count
# Description: Answer total number of commits for current project.
gount() {
  printf "Commits: "
  git rev-list --count HEAD
}

# Label: Git Push
# Description: Pushes changes to remote repository with dynamic branch creation if non-existent.
gp() {
  local branch="$(_git_branch_name)"

  if [[ "$(git config --get branch.$branch.remote)" == "." ]]; then
    git push --set-upstream origin "$branch"
  else
    git push
  fi
}

# Label: Git Push (all)
# Description: Push changes for projects in current directory.
gpa() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Only process projects that have changes.
        if [[ "$(git status --short --branch)" == *"[ahead"*"]" ]]; then
          printf "\033[36m${project}\033[m:\n" # Outputs in cyan color.
          gp
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Pull (all)
# Description: Pull new changes from remote branch for projects in current directory.
gpua() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Capture current project status.
        local results=$(git pull | tail -1)

        # Print project name and Git activity only if Git activity was detected.
        printf "\033[36m${project}\033[m: " # Outputs in cyan color.

        if [[ -n "$results" && "$results" != "Already up-to-date." ]]; then
          printf "\n  %s\n" "$results"
        else
          printf "✓\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Remote Add
# Description: Add and track a remote repository.
# Parameters: $1 (required) - Repository URL, $2 (optional) - Name. Default: upstream
gra() {
  local url="$1"
  local name="${2:-upstream}"

  if [[ -z "$url" ]]; then
    printf "%s\n" "ERROR: Repository URL must be supplied."
    return 1
  fi

  git remote add -t "$(_git_branch_default)" -f "$name" "$url"
}

# Label: Git Rebase (interactive)
# Description: Rebase commits, interactively.
# Parameters: $1 (optional) - The number of commits or label (i.e. branch/tag) to rebase to.
grbi() {
  local number_pattern="^[0-9]+$"
  local label_pattern="^[0-9a-zA-Z\_-]+$"
  local parent_sha=$(git log --pretty=format:%h -n 1 "$(_git_branch_sha)^" 2> /dev/null || :)
  local value="${1:-$parent_sha}"

  if [[ "$value" =~ $number_pattern ]]; then
    git rebase --keep-empty --interactive "@~${value}"
  elif [[ "$(_git_branch_name)" == "$(_git_branch_default)" && -z "$(git config remote.origin.url)" ]]; then
    git rebase --keep-empty --interactive --root
  elif [[ "$value" =~ $label_pattern ]]; then
    git rebase --keep-empty --interactive "$value"
  else
    printf "%s\n" "Invalid commit SHA, branch label, or repo has remote: $value."
    return 1
  fi
}

# Label: Git Rebase (quick)
# Description: Rebase commits, quickly. Identical to `grbi` function but skips editor.
# Parameters: $1 (optional) - The commit number or branch to rebase to. Default: upstream or root.
grbq() {
  GIT_EDITOR=true grbi "$1"
}

# Label: Git Root
# Description: Change to repository root directory regardless of current depth.
groot() {
  cd "$(git rev-parse --show-toplevel)"
}

# Label: Git Set Config Value (all)
# Description: Set key value for projects in current directory.
# Parameters: $1 (required) - The key name, $2 (required) - The key value.
gseta() {
  if [[ "$1" && "$2" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          # Set key value for current project.
          git config "$1" "$2"

          # Print project (cyan) and email (white).
          printf "\033[36m${project}\033[m: $1 = $2\n"
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Key and value must be supplied."
    return 1
  fi
}

# Label: Git Status (all)
# Description: Answer status of projects with uncommited/unpushed changes.
gsta() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Capture current project status info as an array.
        local results=($(git status --short --branch))
        local size=${#results[@]}

        # Print Git activity if Git activity detected (white).
        if [[ $size -gt 2 ]]; then
          # Remove first and second elements since they contain branch info.
          results=("${results[@]:1}")
          results=("${results[@]:1}")

          # Print project (cyan).
          printf "\033[36m${project}\033[m:\n"

          # Print results (white).
          for line in "${results[@]}"; do
            printf "%s" "$line "
            if [[ $newline == 1 ]]; then
              printf "\n"
              local newline=0
            else
              local newline=1
            fi
          done
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Statistics
# Description: Answer statistics for current project.
gstats() {
  if [[ -d ".git" ]]; then
    gount
    printf "Branches: %s\n" "$(gbl | wc -l | tr -d ' ')"
    printf "Tags: %s\n" "$(git tag | wc -l | tr -d ' ')"
    printf "Stashes: %s\n" "$(_git_stash_count)"
    printf "Size: %s\n" "$(git count-objects --human-readable)"
  fi
}

# Label: Git Statistics (all)
# Description: Answer statistics for all projects in current directory.
gstatsa() {
  while read -r project; do
    (
      cd "$project"
      printf "\033[36m${project}\033[m:\n" # Print project (cyan) and message (white).
      gstats
    )
  done < <(ls -A1)
}

# Label: Git Standup
# Description: Answer summarized list of activity since yesterday for projects in current directory.
gsup() {
  gince "yesterday.midnight" "midnight" $(git config user.name)
}

# Label: Git Tag Delete
# Description: Delete local and remote tag (if found).
# Parameters: $1 (required) - The tag name.
gtagd() {
  if [[ -z "$1" ]]; then
    printf "%s\n" "ERROR: Tag name must be supplied."
    return 1
  fi

  read -p "Delete '$1' tag from local and remote repositories. Continue (y/n)?: " response

  if [[ "$response" == 'y' ]]; then
    printf "%s " "Local:"
    if [[ -n "$(git tag --list $1)" ]]; then
      git tag --delete "$1"
    else
      printf "%s\n" "No tag found."
    fi

    printf "%s " "Remote:"
    if [[ $(git config remote.origin.url) && -n "$(git ls-remote --tags origin | rg $1)" ]]; then
      git push --delete origin "$1"
    else
      printf "%s\n" "No tag found."
    fi
  else
    printf "%s\n" "Tag deletion aborted."
  fi
}

# Label: Git Tag Rebuild
# Description: Rebuild a previous tag. WARNING: Use with caution, especially if previously published.
# Parameters: $1 (required) - Version, $2 (required) - Release notes path, $3 (optional) - Creation date/time. Default: current date/time.
gtagr() {
  local version="$1"
  local path="$2"
  local datetime="${3:-$(date '+%Y-%m-%d %H:%M:%S')}"

  GIT_COMMITTER_DATE="$datetime" git tag --force --sign --file "$path" "$version"
}

# Label: Git Tail
# Description: Answer commit history since last tag for current project (copies results to clipboard).
gtail() {
  if [[ ! -d ".git" ]]; then
    printf "%s\n" "ERROR: Not a Git repository."
    return 1
  fi

  if [[ $(_git_commits_since_last_tag) ]]; then
    _git_commits_since_last_tag | _copy_and_print "\n"
  else
    printf "%s\n" "No commits since last tag."
  fi
}

# Label: Git Tail (all)
# Description: Answer commit history count since last tag for projects in current directory.
gtaila() {
  # Iterate through root project directories.
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        local info=$(_git_commit_count_since_last_tag "$project")
        if [[ ! "$info" == *": 0"* ]]; then
          printf "%s\n" "$info"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Upstream Commit Count (all)
# Description: Answer upstream commit count since last pull for projects in current directory.
gucca() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Capture upstream project commit count.
        git fetch --quiet
        local count=$(git log ..@{upstream} --pretty=format:"%h" | wc -l | tr -d ' ')

        if [[ $count -gt '0' ]]; then
          # Print project (cyan) and commit count (white).
          printf "\033[36m${project}\033[m: $count\n"
        fi
      fi
    )
  done < <(ls -A1)
}

# Label: Git Nuke
# Description: Permanently destroy and erase a file from history. UNRECOVERABLE!
# Parameters: $1 (optional) - The file to destroy.
guke() {
  local file="$1"

  if [[ -z "$file" ]]; then
    printf "%s\n" "ERROR: File to nuke must be supplied."
    return 1
  fi

  printf "\033[31m" # Switch to red font.
  read -p "Permanently delete '$file' from the local repository. Continue (y/n)?: " response
  printf "\033[m" # Switch to white font.

  if [[ "$response" == 'y' ]]; then
    git-filter-repo --force --invert-paths --path "$file"
  else
    printf "%s\n" "Nuke aborted."
  fi
}

# Label: Git Unset (all)
# Description: Unset key value for projects in current directory.
# Parameters: $1 (required) - The key name.
gunseta() {
  if [[ "$1" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -d ".git" ]]; then
          # Unset key for current project with error output suppressed.
          git config --unset "$1" &> /dev/null

          # Print project (cyan).
          printf "\033[36m${project}\033[m: \"$1\" key removed.\n"
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Key must be supplied."
    return 1
  fi
}

# Label: Git Update
# Description: Fetch commits, prune untracked references, review each commit (optional, with diff), and pull (optional).
gup() {
  git fetch --quiet
  commits=($(git log --reverse --no-merges --pretty=format:"%h" ..@{upstream}))

  if [[ ${#commits[@]} == 0 ]]; then
    printf "%s\n" "All is quiet, nothing to update."
    return 0
  fi

  printf "%s\n" "Commit Summary:"
  hr '-'
  git log --reverse --no-merges --pretty=format:"$(_git_log_line_format)" ..@{upstream}
  hr '-'

  printf "%s\n" "Commit Review (↓${#commits[@]}):"

  local counter=1
  for commit in "${commits[@]}"; do
    hr '-'
    printf "[$counter/${#commits[@]}] "
    counter=$((counter + 1))

    _git_show_details $commit

    printf "\n"
    read -p "View Diff (y = yes, n = no, q = quit)? " response

    case $response in
      'y')
        git difftool $commit^!;;
      'n');;
      'q');;
      *)
        printf "%s\n" "ERROR: Invalid option.";;
    esac

    break
  done

  hr '-'
  read -p "Commit Pull (y/n)? " response

  if [[ "$response" == 'y' ]]; then
    git pull
  fi
}

# Label: Git Author Contributions
# Description: Answers total lines added/removed by author for repo (with emphasis on deletion).
# Parameters: $1 (optional) - Author name. Default: Current user.
guthorc() {
  local author="${1:-$(git config --get user.name)}"

  if [[ -z "$author" ]]; then
    printf "%s\n" "ERROR: Author name required."
    return 1
  fi

  git log --author="$author" \
          --pretty=tformat: --numstat \
          | awk -v author="$author" \
            'BEGIN {
              initial_pattern = "\033[1;34m%s\033[0m: Added: \033[0;31m%s\033[0m, Removed: \033[0;32m%s\033[0m, "
              positive_pattern = initial_pattern "Total: \033[0;32m%s\033[0m.\n";
              neutral_pattern = initial_pattern "Total: %s.\n";
              negative_pattern = initial_pattern "Total: \033[0;31m%s\033[0m.\n";
            }
            {
              added += $1;
              removed += $2;
              total += $1 - $2;
            }
            END {
              if (total > 0)
                printf negative_pattern, author, added, removed, total
              else if (total < 0)
                printf positive_pattern, author, added, removed, total
              else
                printf neutral_pattern, author, added, removed, total
            }'
}

# Label: Git Authors (all)
# Description: Answer author commit activity per project (ranked highest to lowest).
guthorsa() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        # Print project (cyan) and message (white).
        printf "\033[36m${project}\033[m:\n"
        guthors
      fi
    )
  done < <(ls -A1)
}

# Label: Git Verify and Clean
# Description: Verify and clean objects for current project.
gvac() {
  printf "%s\n\n" "Verifying connectivity and validity of the objects in Git repository..."
  git fsck

  printf "%s\n" "Packing unpacked objects into a single pack and removing redundant packs..."
  git repack -Ad

  printf "\n%s\n\n" "Cleaning unnecessary files and optimizing local Git repository..."
  git maintenance run --task=gc

  printf "%s\n\n" "Pruning rerere records of older conflicting merges..."
  git rerere gc
}

# Label: Git Verify and Clean (all)
# Description: Verify and clean objects for projects in current directory.
gvaca() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        printf "\n\033[36m${project}\033[m:\n" # Outputs in cyan color.
        git fsck && git repack -Ad && git maintenance run --task=gc && git rerere gc
      fi
    )
  done < <(ls -A1)
}

# Label: Git Worktree Add
# Description: Add and switch to new worktree.
# Parameters: $1 (required) - Worktree/branch name, $2 (required) Option.
gwa() {
  local name="$1"
  local option="$2"
  local project_name="$(basename $(pwd))"
  local worktree_path="../$project_name-$name"

  if [[ -z "$name" ]]; then
    printf "%s\n" "ERROR: Worktree name must be supplied."
    return 1
  fi

  if [[ "$option" != "d" && -n $(git branch --list "$name") ]]; then
    printf "%s\n" "ERROR: Invalid worktree, local branch exists."
    return 1
  fi

  case $option in
    'd')
      git worktree add --detach "$worktree_path" HEAD;;
    'r')
      git worktree add -b "$name" "$worktree_path" origin/"$name";;
    'l')
      git worktree add -b "$name" "$worktree_path" "$(_git_branch_default)";;
    *)
      printf "%s\n" "ERROR: Invalid worktree option: Use: (d)etach, (r)emote, or (l)ocal."
      return 1;;
  esac

  printf "%s\n" "Syncing project files..."
  git ls-files --others | rsync --links --files-from - "$(pwd)/" "$worktree_path/"
  cd "$worktree_path"
}

# Label: Git Worktree Delete
# Description: Deletes current Git worktree.
gwd() {
  local project_name="$(basename $(git rev-parse --show-toplevel) | cut -d'-' -f1)"
  local worktree_dir="$(pwd)"
  local branch="$(_git_branch_name)"

  if [[ "$(git status --short)" ]]; then
    printf "%s\n" "ERROR: Git worktree has uncommitted changes."
    return 1
  else
    cd ../$project_name
    read -p "Git worktree: $worktree_dir. Delete (y/n)?: " response

    if [[ "$response" == 'y' ]]; then
      rm -rf $worktree_dir
      git worktree prune
      gbdl "$branch"
      git branch --delete --force "$branch"
    fi
  fi
}

# Label: Git Week
# Description: Answer summarized list of current week activity for projects in current directory.
gweek() {
  gince "last Monday 12am"
}

# Label: Git Sync
# Description: Syncs up remote changes and deletes pruned/merged branches.
# Parameters
gync() {
  if [[ $(_git_branch_name) != "$(_git_branch_default)" ]]; then
    printf "%s\n" "ERROR: Whoa, switch to default branch first."
    return 1
  fi

  git pull && gbdm
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: GitHub - [https://github.com]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: GitHub
# Description: View GitHub details for current project.
# Parameters: $1 (optional) - The option selection, $2 (optional) - The option input.
gh() {
  if [[ -d ".git" ]]; then
    while true; do
      if [[ $# == 0 ]]; then
        printf "\n%s\n" "Usage: gh OPTION"
        printf "\n%s\n" "GitHub Options (default browser):"
        printf "%s\n" "  o: Open repository."
        printf "%s\n" "  i: Open repository issues."
        printf "%s\n" "  c: Open repository commits. Options:"
        printf "%s\n" "     HASH: Open commit."
        printf "%s\n" "  f: Copy repository file URL."
        printf "%s\n" "  b: Open repository branches. Options:"
        printf "%s\n" "     c: Open current branch."
        printf "%s\n" "     d: Open diff for current branch."
        printf "%s\n" "     r: Open pull request for current branch."
        printf "%s\n" "  t: Open repository tags."
        printf "%s\n" "  r: Open repository pull requests."
        printf "%s\n" "     NUMBER: Open pull request."
        printf "%s\n" "     l: List pull requests."
        printf "%s\n" "  w: Open repository wiki."
        printf "%s\n" "  p: Open repository pulse."
        printf "%s\n" "  g: Open repository graphs."
        printf "%s\n" "  s: Open repository settings."
        printf "%s\n" "  u: Print and copy repository URL. Options:"
        printf "%s\n" "     HASH: Print and copy commit URL."
        printf "%s\n" "     l: Print and copy last commit URL."
        printf "%s\n\n" "  q: Quit/Exit."
        read -p "Enter selection: " response
        printf "\n"
        _process_gh_option $response "$2"
      else
        _process_gh_option "$1" "$2" "$3"
      fi
      break
    done
  else
    printf "%s\n" "ERROR: Not a Git repository!"
    return 1
  fi
}

# Label: GitHub Pull Request (all)
# Description: Open pull requests for all projects in current directory (non-default branches only).
ghpra() {
  while read -r project; do
    (
      cd "$project"

      if [[ -d ".git" ]]; then
        if [[ "$(_git_branch_name)" != "$(_git_branch_default)" ]]; then
          gh b r
        fi
      fi
    )
  done < <(ls -A1)
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: less - [https://en.wikipedia.org/wiki/Less_(Unix)]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Less Interactive
# Description: Inspect file, interactively.
# Parameters: $1 (required) - The file path.
lessi() {
  if [[ "$1" ]]; then
    less +F --LONG-PROMPT --LINE-NUMBERS --RAW-CONTROL-CHARS --QUIET --quit-if-one-screen -i "$1"
  else
    printf "%s\n" "ERROR: File path must be supplied."
    printf "%s\n" "TIP: Use CONTROL+c to switch to VI mode, SHIFT+f to switch back, and CONTROL+c+q to exit."
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: License Finder - [https://github.com/pivotal/LicenseFinder]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: License Finder (add)
# Description: Adds library to global list.
# Parameters: $1 (required) - Library, $2 (required) - Why.
licensea() {
  local library="$1"
  local why="$2"

  if [[ -z "$library" ]]; then
    printf "%s\n" "ERROR: Must supply library."
    return 1
  fi

  if [[ -z "$why" ]]; then
    printf "%s\n" "ERROR: Explain why the license is safe."
    return 1
  fi

  license_finder approval add "$library" --who "$(git config user.name)" --why "$why"
}

# Label: License Finder (include)
# Description: Include license in global list.
# Parameters: $1 (required) - License, $2 (required) - Why.
licensei() {
  local license="$1"
  local why="$2"

  if [[ -z "$license" ]]; then
    printf "%s\n" "ERROR: Must supply license."
    return 1
  fi

  if [[ -z "$why" ]]; then
    printf "%s\n" "ERROR: Explain why the license is safe."
    return 1
  fi

  license_finder whitelist add "$license" --who "$(git config user.name)" --why "$why"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: lsof - [https://people.freebsd.org/~abe]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Port
# Description: List file activity on given port.
# Parameters: $1 (required) - The port number.
port() {
  if [[ "$1" ]]; then
    lsof -i :$1 +c0
  else
    printf "%s\n" "ERROR: Port number must be supplied."
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Minisign - [https://jedisct1.github.io/minisign]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Minisign Sign File
# Description: Sign a file.
# Parameters: $1 (required) - File path, $2 (optional) - Comment.
sigf() {
  local path="$1"
  local comment="$2"

  minisign -S -s "$HOME/.minisign/alchemists.key" -m "$path" -t "$comment"
}

# Label: Minisign Generate
# Description: Generate private and public key pair.
# Parameters: $1 (required) - Key pair name.
sigg() {
  local name="$1"

  minisign -G -s "$HOME/.minisign/$name.key" -p "$HOME/.minisign/$name.pub"
}

# Label: Minisign Verify File
# Description: Verify signed file.
# Parameters: $1 (required) - File path.
sigv() {
  local path="$1"

  minisign -V -p "$HOME/.minisign/alchemists.pub" -m "$path"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: OpenSSL  - [https://openssl.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: SSL Certificate Creation
# Description: Create SSL certificate.
# Parameters: $1 (required) - The domain name.
sslc() {
  local name="$1"

  if [[ -z "$name" ]]; then
    printf "%s\n" "ERROR: Domain name for SSL certificate must be supplied."
    return 1
  fi

cat > "$name.cnf" <<-EOF
  [req]
  distinguished_name = req_distinguished_name
  x509_extensions = v3_req
  prompt = no
  [req_distinguished_name]
  CN = *."$name"
  [v3_req]
  keyUsage = keyEncipherment, dataEncipherment
  extendedKeyUsage = serverAuth
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = *."$name"
  DNS.2 = "$name"
EOF

  openssl req -new \
              -newkey rsa:2048 \
              -sha256 \
              -days 3650 \
              -nodes \
              -x509 \
              -keyout "$name.key" \
              -out "$name.crt" \
              -config "$name.cnf"

  rm -f "$name.cnf"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Overmind - [https://github.com/DarthSim/overmind]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Overmind Connect
# Description: Connect to running process.
# Parameters: $1 (optional) - Process. Default: "web".
omc() {
  local process="${1:-web}"
  overmind connect "$process"
}

# Label: Overmind Restart
# Description: Restart running process.
# Parameters: $1 (optional) - Process. Default: "web".
omr() {
  local process="${1:-web}"
  overmind restart "$process"
}

# Label: Overmind Start
# Description: Start processes.
# Parameters: $1 (optional) - Port. Default: 3000.
oms() {
  local port=${1:-3000}
  overmind start --port $port --port-step 10
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: PostgreSQL - [https://www.postgresql.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: PostgreSQL Template
# Description: Edit PostgreSQL template.
# Parameters: $1 (required) - The username.
pgt() {
  local user="$1"

  if [[ -n "$user" ]]; then
    psql -U "$user" template1
  else
    printf "%s\n" "ERROR: PostgreSQL username must be supplied."
    return 1
  fi
}

# Label: PostgreSQL User Create
# Description: Create PostgreSQL user.
# Parameters: $1 (required) - The username.
pguc() {
  local user="$1"

  if [[ -n "$user" ]]; then
    createuser --interactive "$user" -P
  else
    printf "%s\n" "ERROR: PostgreSQL username must be supplied."
    return 1
  fi
}

# Label: PostgreSQL User Drop
# Description: Drop PostgreSQL user.
# Parameters: $1 (required) - The username.
pgud() {
  local user="$1"

  if [[ -n "$user" ]]; then
    dropuser --interactive "$user"
  else
    printf "%s\n" "ERROR: PostgreSQL username must be supplied."
    return 1
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Rake - [https://github.com/ruby/rake]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Rake (all)
# Description: Run default Rake tasks for projects in current directory.
rakea() {
  while read -r project; do
    (
      cd "$project"
      if [[ -f "Gemfile.lock" && -f "Rakefile" ]]; then
        # Prints project (cyan).
        printf "\033[36m${project}\033[m: "

        rake > /dev/null
        printf "\n"
      fi
    )
  done < <(ls -A1)
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: RSpec  - [https://rspec.info]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: RSpec (all)
# Description: Run RSpec for projects in current directory.
rsall() {
  while read -r project; do
    (
      cd "$project"

      if [[ -f "Gemfile.lock" && -d "spec" ]]; then
        local json=$(rspec spec --format json)
        local examples=$(printf "%s" "$json" | jq ".summary.example_count" )
        local failures=$(printf "%s" "$json" | jq ".summary.failure_count" )
        local pending=$(printf "%s" "$json" | jq ".summary.pending_count" )
        local duration=$(printf "%s" "$json" | jq ".summary.duration" )

        # Prints project (cyan).
        printf "\033[36m${project}\033[m: "

        # Prints total examples (white).
        printf "$examples examples, "

        # Prints total failures (red).
        _toggle_total_color "$failures" "failures" "\033[31m"
        printf ", "

        # Prints total pending (yellow).
        _toggle_total_color "$pending" "pending" "\033[33m"
        printf ", "

        # Prints total duration (white).
        printf "%s\n" "$duration seconds."
      fi
    )
  done < <(ls -A1)
}

# Label: RSpec Bisect
# Description: Debug RSpec failure using bisect to automatically determine where failure is occuring.
# Parameters: $1 (optional) - The seed. Default: 2112, $2 (optional) - Debug verbosity. Default: "normal".
rsb() {
  local seed=${1:-2112}
  local verbosity="${2:-normal}"

  rspec --seed $seed --bisect="$verbosity" spec
}

# Label: RSpec Debug
# Description: Debug intermittent RSpec failure(s) by running spec(s) until failure is detected.
# Parameters: $1 (optional) - The spec to debug. Default: "spec".
rsd() {
  local subject=${1:-spec}

  while [ $? == 0 ]; do
    rspec "$subject"
  done
}

# Label: RSpec Profile
# Description: Runs RSpec specs with profiling enabled.
# Parameters: $1 (optional) - The number of top specs to profile. Default: 5.
rsp() {
  local number=${1:-5}
  rspec --profile $number spec
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Ruby - [https://www.ruby-lang.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Ruby Server
# Description: Serve web content from current directory via WEBrick.
# Parameters: $1 (optional) - The custom port. Default: 3030.
rbs() {
  local default_port=3030
  local custom_port=$1

  ruby -run -e httpd . --port ${custom_port:-$default_port}
}

# Label: Ruby Upgrade (all)
# Description: Upgrade Ruby projects in current directory with new Ruby version.
# Parameters: $1 (required) - The new version to upgrade to. Example: 2.3.0.
rbua() {
  if [[ "$1" ]]; then
    while read -r project; do
      (
        cd "$project"

        if [[ -e ".ruby-version" ]]; then
          local old_version=$(head -n 1 .ruby-version)
          local new_version="$1"

          printf "\033[36m${project}\033[m: " # Outputs project in cyan color.

          if [[ "$old_version" != "$new_version" ]]; then
            printf "%s\n" "$new_version" > .ruby-version
            printf "%s\n" "$old_version --> $new_version"
          else
            printf "✓\n"
          fi
        fi
      )
    done < <(ls -A1)
  else
    printf "%s\n" "ERROR: Version must be supplied."
    return 1
  fi
}

# Label: Ruby Version (all)
# Description: Show current Ruby version for all projects in current directory.
rbva() {
  while read -r project; do
    (
      cd "$project"

      if [[ -e ".ruby-version" ]]; then
        local version=$(head -n 1 .ruby-version)

        # Outputs project as cyan and version as white color.
        printf "\033[36m${project}\033[m: $version\n"
      fi
    )
  done < <(ls -A1)
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Ruby Gems  - [https://rubygems.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Gem Dependency Search
# Description: Finds a gem defined within a Gemfile or a gemspec.
# Parameters: $1 (required) - The gem name.
gemdep() {
  local gem_name="$1"

  if [[ -z "$gem_name" ]]; then
    printf "%s\n" "ERROR: Gem name must be supplied!"
    return 1
  fi

  ag "(add.*dependency \"$gem_name\"|add.*dependency '$gem_name'|gem \"$gem_name\"|gem '$gem_name')" .
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Ruby on Rails  - [https://rubyonrails.org]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Ruby on Rails New
# Description: Create new Rails application from selected option.
# Parameters: $1 (required) - Application name, $2 (optional) - Option.
railsn() {
  if [[ "$1" ]]; then
    while true; do
      if [[ $2 ]]; then
        _process_rails_new_option "$1" "$2"
      else
        printf "%s\n" "\nUsage: railsn NAME TEMPLATE"
        printf "\n%s\n\n" "Select Ruby on Rails generation option:"
        printf "%s\n" "  default: Rails Default"
        printf "%s\n" "      api: Rails API"
        printf "%s\n" "     slim: Rails Slim"
        printf "%s\n" "    dummy: Rails Dummy"
        printf "\n"
        read -p "Please pick one (or type 'q' to quit): " response
        printf "\n"
        _process_rails_new_option "$1" $response
      fi
      break
    done
  else
    printf "%s\n" "ERROR: Rails application name must be supplied."
    return 1
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Silicon  - [https://github.com/Aloxaf/silicon]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Silicon Copy
# Description: Generates and copies code snippet image to clipboard.
# Parameters: $1 (required) - Path, $2 (optional) - Language. Default: Ruby, $3 (optional) Lines.
scc() {
  local path="$1"
  local language="${2:-rb}"
  local lines="${3:-0}"

  silicon --language "$language" \
          --theme DarkNeon \
          --background "#0000" \
          --no-window-controls \
          --pad-horiz 0 \
          --pad-vert 0 \
          --highlight-lines "$lines" \
          --to-clipboard \
          "$path"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# SECTION: Wormhole - [https://magic-wormhole.readthedocs.io]
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Label: Wormhole Receive
# Description: Receive encrypted payload (i.e. text, file, etc.)
# Parameters: $1 (required) - Secret code.
whr() {
  wormhole --appid $(defaults read io.alchemists.www WormholeID) receive "$1"
}

# Label: Wormhole Send
# Description: Send encrypted path (i.e. file or directory).
# Parameters: $1 (required) - Path to be sent.
whs() {
  wormhole --appid $(defaults read io.alchemists.www WormholeID) send "$1"
}

# Label: Wormhole Send Text
# Description: Send encrypted text.
# Parameters: $1 (required) - Text to be sent.
whst() {
  wormhole --appid $(defaults read io.alchemists.www WormholeID) send --text "$1"
}

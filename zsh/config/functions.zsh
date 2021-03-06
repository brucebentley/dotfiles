################################################################################
#                                                                              #
# FUNCTIONS                                                                    #
#                                                                              #
################################################################################

##
# —[ GENERAL ]— CREATE A NEW DIRECTORY AND ENTER IT
##
function mkd() {
    mkdir -p "$@" && cd "$_";
}

##
# —[ GENERAL ]— CHANGE WORKING DIRECTORY TO THE TOP-MOST FINDER WINDOW LOCATION
##
function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
}

##
# —[ GENERAL ]— CREATE A .tar.gz ARCHIVE, USING `zopfli`, `pigz` OR `gzip` FOR COMPRESSION
##
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

##
# —[ GENERAL ]— DETERMINE SIZE OF A FILE OR TOTAL SIZE OF A DIRECTORY
##
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

##
# —[ GENERAL ]— USE GIT’S COLORED DIFF WHEN AVAILABLE
##
hash git &>/dev/null;
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@";
    }
fi;

##
# —[ GENERAL ]— CREATE A DATA URL FROM A FILE
##
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

##
# —[ GENERAL ]— CREATE A git.io SHORT URL
##
function gitio() {
    if [ -z "${1}" -o -z "${2}" ]; then
        echo "Usage: \`gitio slug url\`";
        return 1;
    fi;
    curl -i https://git.io/ -F "url=${2}" -F "code=${1}";
}

##
# —[ GENERAL ]— START AN HTTP SERVER FROM A DIRECTORY, OPTIONALLY SPECIFYING THE PORT
##
function server() {
    local port="${1:-8000}";
    sleep 1 && open "http://localhost:${port}/" &
    # SET THE DEFAULT CONTENT-TYPE TO `text/plain` INSTEAD OF `application/octet-stream`
    # AND SERVE EVERYTHING AS UTF-8 (ALTHOUGH NOT TECHNICALLY CORRECT, THIS DOESN’T BREAK ANYTHING FOR BINARY FILES)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

function server() {
    local currentDir="${PWD##*/}";
    local localhostname
    localhostname="${1:-${currentDir}}";
    local port
    port="${2:-4443}";
    local certpath
    certpath="${3:-${HOME}/dev/Personal/certs/localhost.pem}";
    local keypath
    keypath="${3:-${HOME}/dev/Personal/certs/localhost-key.pem}";

    sleep 1 && open "https://${localhostname}.dev.local:${port}/" &

    # SET THE DEFAULT CONTENT-TYPE TO `text/plain` INSTEAD OF `application/octet-stream`
    # AND SERVE EVERYTHING AS UTF-8 (ALTHOUGH NOT TECHNICALLY CORRECT, THIS DOESN’T BREAK ANYTHING FOR BINARY FILES)
    python "${HOME}"/dotfiles/shellscripts/python/simple-server.py "${localhostname}" "${port}" "${certpath}" "${keypath}";
}



#
# —[ GENERAL ]— START A PHP SERVER FROM A DIRECTORY, OPTIONALLY SPECIFYING THE PORT
# (REQUIRES PHP 5.4.0+.)
##
function phpserver() {
    local port="${1:-4000}";
    local ip=$(ipconfig getifaddr en1);
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}";
}

##
# —[ GENERAL ]— COMPARE ORIGINAL AND GZIPPED FILE SIZE
##
function gz() {
    local origsize=$(wc -c < "$1");
    local gzipsize=$(gzip -c "$1" | wc -c);
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
    printf "orig: %d bytes\n" "$origsize";
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

##
# —[ GENERAL ]— SYNTAX-HIGHLIGHT JSON STRINGS OR FILES
#
# @usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
##
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript;
    else # pipe
        python -mjson.tool | pygmentize -l javascript;
    fi;
}

##
# —[ GENERAL ]— RUN `dig` AND DISPLAY THE MOST USEFUL INFO
##
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

##
# —[ GENERAL ]— UTF-8-ENCODE A STRING OF UNICODE SYMBOLS
##
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

##
# —[ GENERAL ]— DECODE \x{ABCD}-STYLE UNICODE ESCAPE SEQUENCES
##
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

##
# —[ GENERAL ]— GET A CHARACTER’S UNICODE CODE POINT
##
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # PRINT A NEWLINE UNLESS WE’RE PIPING THE OUTPUT TO ANOTHER PROGRAM.
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

##
# —[ GENERAL ]— GET SSL CERTIFICATE(S)
#
# SHOW ALL THE NAMES (CNS AND SANS) LISTED IN THE SSL CERTIFICATE
# FOR A GIVEN DOMAIN.
##
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

##
# —[ GENERAL ]— OPEN CURRENT DIRECTORY IN SUBLIME
#
# `s` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN SUBLIME TEXT, OTHERWISE
# OPENS THE GIVEN LOCATION.
##
function s() {
    if [ $# -eq 0 ]; then
        subl -n .;
    else
        subl -n "$@";
    fi;
}

##
# —[ GENERAL ]— OPEN CURRENT DIRECTORY IN VISUAL STUDIO CODE
#
# `a` wITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN VS CODE EDITOR, OTHERWISE
# OPENS THE GIVEN LOCATION.
##
function vs() {
    if [ $# -eq 0 ]; then
        code-insiders -n .;
    else
        code-insiders -n "$@";
    fi;
}

##
# —[ GENERAL ]— OPEN CURRENT DIRECTORY IN VIM
#
# `v` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY IN VIM, OTHERWISE OPENS THE
# GIVEN LOCATION.
##
function v() {
    if [ $# -eq 0 ]; then
        vim .;
    else
        vim "$@";
    fi;
}

##
# —[ GENERAL ]— OPEN CURRENT DIRECTORY
#
#`o` WITH NO ARGUMENTS OPENS THE CURRENT DIRECTORY, OTHERWISE OPENS THE
# GIVEN LOCATION.
##
function o() {
    if [ $# -eq 0 ]; then
        open .;
    else
        open "$@";
    fi;
}

##
# —[ GENERAL ]— TREE DIRECTORY BROWSING
#
# `tre` IS A SHORTHAND FOR `tree` WITH HIDDEN FILES AND COLOR ENABLED, IGNORING
# THE `.git` DIRECTORY, LISTING DIRECTORIES FIRST. THE OUTPUT GETS PIPED INTO
# `less` WITH OPTIONS TO PRESERVE COLOR AND LINE NUMBERS, UNLESS THE OUTPUT IS
# SMALL ENOUGH FOR ONE SCREEN.
##
function tre() {
    tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

##
# —[ GENERAL ]— ALWAYS USE THE CORRECT PROGRAM TO EXTRACT FILES
##
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

##
# —[ GENERAL ]— BOOKMARK MANAGER
#
# @param {string} [$1] Defined bookmark string.
##
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

##
# —[ GENERAL ]— CONVERT HEX COLOR VALUE TO A (NEAREST) 0-256 COLOR INDEX
##
function fromhex() {
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 +
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}

##
# —[ GENERAL ]— IMPORT MONGO DATABASE
##
function importmongodb() {
    # KRIS'S SOLUTION - JULY 19, 2017
    if [[ $1 =~ (.+)\/([^\/]+)\.(.{3})$ ]]; then
        LOC=${BASH_REMATCH[1]}
        FILE=${BASH_REMATCH[2]}
        EXT=${BASH_REMATCH[3]}
    fi
    if [ "$EXT" == "agz" ]; then
        if [ -n "$2" ]; then
            LOC=$2
        fi
        7z e $1 -o$LOC
    fi

    # DATA IMPORT
    echo -e "${bold}${fgYellow}Importing Data ...${reset}"
    # dockerexec $3 "mongorestore --drop $4 --archive=$DOCKER_CONNECT_API_DB/$FILE"
    mongorestore --drop --gzip --archive=$LOC/$FILE $4
    echo $'\n'
    echo -e "${bold}${fgGreen}Done!${reset}"
}

##
# —[ DEVOPS ]— START ANSIBLE
##
function startansible() {
    pyenv shell 2.7.13
    printf 'Now using Python v%s ... \n' ${PYENV_VERSION}
    source $PYTHON/personal/ansible/bin/activate
}

##
# —[ CONNECT ]— START CONNECT-API - (w/out PyCharm)
##
function connectapistartserver() {
    cd $CONNECT_API &&
    # PULL LATEST CHANGES FROM GITHUB
    echo -e "${bold}${fgYellow}Pulling latest code from GitHub...${reset}"
    git fetch origin &&
    git pull origin develop
    echo -e "${bold}${fgGreen}Done!${reset}"
    echo $'\n'

    # START MONGODB
    echo -e "${bold}${fgYellow}Starting MongoDB...${reset}"
    mongod --dbpath $DATA/db --fork --logpath /dev/null
    echo -e "${bold}${fgGreen}Done!${reset}"
    echo $'\n'

    # START CONNECT API
    echo -e "${bold}${fgYellow}Starting the Connect API development server...${reset}"
    source $CONNECT_API_VENV/bin/activate;
    env MBO_ENV="development" DOTENV="$CONNECT_API_ENVIRONMENT/.connect-api.env" python manage.py runserver;
    deactivate;
    echo $'\n'
    echo -e "${bold}${fgYellow}Shutting down the Connect API development server...${reset}"
    echo -e "${bold}${fgGreen}Done!${reset}"

    # STOP MONGODB
    echo $'\n'
    echo -e "${bold}${fgYellow}Shutting down MongoDB...${reset}"
    mongo admin --eval 'db.shutdownServer()' > /dev/null;
    echo -e "${bold}${fgGreen}Done!${reset}"
    echo
}

##
# —[ CONNECT ]— START CELERY
##
function connectstartcelery() {
    cd $CONNECT_API &&

    # WAIT FOR `connect-api` TO INITIALIZE
    echo -e "${bold}${fgYellow}Waiting for connect-api to initialize...${reset}"
    echo $'\n'
    sleep 10 &&

    # STARTING CELERY
    echo -e "${bold}${fgYellow}Starting Celery...${reset}"

    source $CONNECT_API_VENV/bin/activate;
    env MBO_ENV="development" DOTENV="$CONNECT_API_ENVIRONMENT/.connect-api.env" celery -A connect -l info worker;
    deactivate

    # STOP CELERY
    echo $'\n'
    echo -e "${bold}${fgYellow}Shutting down Celery...${reset}"
    echo -e "${bold}${fgGreen}Done!${reset}"
}

##
# —[ KEYCLOAK ]— GET AUTHENTICATION TOKEN
##
function getauthtoken() {
    # BASE KEYCLOAK & API VARIABLE DEFINITION(S)
    KC_BASE_URL=https://sso2-dev.mbopartners.com/auth/realms;
    KC_REALM_NAME=dev;
    KC_CLIENT_ID=connect-web;
    CONNECT_API_URL=http://localhost:8000;

    # CAPTURE USER INPUT(S) & STORE  IN VARIABLES(S)
    echo -en "${bold}${fgBlue}Enter Username: ${reset}"
    read -r USERNAME_INPUT
    echo -en "${bold}${fgBlue}Enter Password: ${reset}"
    read -rs PASSWORD_INPUT
    echo

    # NORMALIZING USER INPUT PARAMETERS
    KC_USERNAME=${USERNAME_INPUT,,};
    KC_PASSWORD=$PASSWORD_INPUT;

    echo -e "${bold}${fgYellow}Generating authenication token for $KC_USERNAME ... ${reset}";
    curl -s \
      "${KC_BASE_URL}/${KC_REALM_NAME}/protocol/openid-connect/token" \
      -H 'Cache-Control: no-cache' -H 'Accept: application/json' \
      -d "client_id=${KC_CLIENT_ID}" \
      -d "username=${KC_USERNAME}" \
      -d "password=${KC_PASSWORD}" \
      -d 'grant_type=password' \
      | jq -r '.access_token' \
      | pbcopy;

    # GRAB THE `ACCESS_TOKEN` FROM CLIPBOARD
    KC_ACCESS_TOKEN=$(pbpaste)

    # COPY THE FULL SNIPPET TO THE CLIPBOARD
    echo -e "document.cookie=\"ACCESS_TOKEN=$KC_ACCESS_TOKEN;path=/;\"\\ndocument.cookie=\"CONNECT_API_URL=$CONNECT_API_URL;path=/;\"" | pbcopy;
    echo
    CLIPBOARD_CONTENTS=$(pbpaste)
    # DISPLAY THE OUTPUT TO THE USER IN TERMINAL
    echo -e "${fgWhite}$CLIPBOARD_CONTENTS${reset}"
    echo
}

##
# —[ KEYCLOAK ]— GET KEYCLOAK TOKEN
##
function getkeycloaktoken() {
    if [ -z "${1}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\n${fgYellow}getauthtoken <associate|enterprise>${reset}"
        echo
    else
        # SAVE INITIAL BASH ARGUMENTS IN VARIABLE(S)
        ROLE_TYPE_INPUT="$1"

        # CAPTURE USER INPUT(S) & STORE  IN VARIABLES(S)
        echo -en "${bold}${fgViolet}Enter Username: ${reset}"
        read USERNAME_INPUT
        echo -en "${bold}${fgViolet}Enter Password: ${reset}"
        read -s PASSWORD_INPUT
        echo

        # NORMALIZING USER INPUT(S)
        KC_USERNAME=${USERNAME_INPUT,,};
        KC_PASSWORD=$PASSWORD_INPUT;
        ROLE_TYPE=${ROLE_TYPE_INPUT,,};

        source $VENVS_MBO/local-start/bin/activate;
        echo -e "${bold}${fgYellow}Generating authenication token for $KC_USERNAME ... ${reset}";
        python $SCRIPTS_MBO/local_start/local_start.py -a connect-webapp -u $KC_USERNAME -p $KC_PASSWORD -v $ROLE_TYPE | pbcopy;
        deactivate;
        echo

        # STORE CLIPBOARD CONTENTS IN VARIABLE
        CLIPBOARD_CONTENTS=$(pbpaste);
        echo -e "${fgWhite}$CLIPBOARD_CONTENTS${reset}";
        echo
    fi
}

##
# —[ DOCKER ]— CONNECT TO A SPECIFIED DOCKER CONTAINER
##
dockerssh() {
    if [ -z "${1}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\n${fgYellow}dockerssh <container_id>${reset}"
        echo
    else
        dockerexec $1 /bin/bash
    fi
}

dockerexec() {
    if [ -z "${1}" ]; then
        # DISPLAY USAGE IF NO PARAMETERS GIVEN
        echo -en "${bold}${fgViolet}@USAGE:${reset}\n${fgYellow}dockerexec <container_id> <command>${reset}"
        echo
    else
        sudo docker exec -i -t $1 $2
    fi
}

##
# —[ FFMPEG ]— DOWNLOAD PROTECTED STREAMING VIDEOS USING THEIR `m3u8` PLAYLIST CHUNKS.
##
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
# ZSH
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

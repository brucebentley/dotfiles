# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Aliases
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# foreach file (
#     core.zsh
#     macos.zsh
#     dev.zsh
#     node.zsh
#     yarn.zsh
#     docker.zsh
#     kubernetes.zsh
#     ruby.zsh
# ) {
#     source $ZSH/config/aliases/$file
# }


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Core Aliases For Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Enable Simple Aliases To Be sudo'ed. ( "sudone"? )
# Note: If the last character of an alias is a SPACE or TAB character, the next
# command word following the alias is also checked for alias expansion.
# http://www.gnu.org/software/bash/manual/bashref.html#Aliases
alias sudo='sudo ';


# - - - - - - - - - - - - - - - - - - - -
# Directory Shortcuts
# - - - - - - - - - - - - - - - - - - - -

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Shortcuts.
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dr="cd ~/Dropbox"
alias dt="cd ~/Desktop"
alias p="cd ~/Projects"
alias s="cd ~/Sites"
alias data="cd ~/data"
alias dev="cd ~/dev"
alias dot="cd ~/dotfiles"
alias ss="cd ~/.ssh"


# - - - - - - - - - - - - - - - - - - - -
# Paths + Binaries
# - - - - - - - - - - - - - - - - - - - -

# Send Requests To `www` Servers And Your Local File System.
# Note: The macOS file system is case-insensitive by default, so use aliases to get
# `GET` / `HEAD` /... working. ( otherwise `HEAD` would execute `/usr/bin/head` ).
[[ "$OSTYPE" =~ ^darwin ]] && for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="/usr/bin/lwp-request -m $method";
done;
unset method;


# - - - - - - - - - - - - - - - - - - - -
# Confirm Before Overwriting
# - - - - - - - - - - - - - - - - - - - -
# I Know It Is Bad Practice To Override The Default Commands, But This Is For
# My Own Safety. If You Really Want The Original "instakill" Versions, You Can
# Use "command rm", "\rm", Or "/bin/rm" Inside Your Own Commands, Aliases, Or
# Shell Functions.
# Note: That Separate Scripts Are Not Affected By The Aliases Defined Here.
alias cp='cp -i';
alias mv='mv -i';
alias rm='rm -i';


# - - - - - - - - - - - - - - - - - - - -
# Editors + Pagers
# - - - - - - - - - - - - - - - - - - - -
alias nano='nano -w';
alias pico='nano';
alias vi='vim';
export EDITOR='nvim';

# Make Sure "View" As-Is Works When stdin Is Not A Terminal And Prevent The
# Normal Ensuing Keyboard Input Chaos.
function view {
    local args=("$@");
    if ! [ -t 0 ] && ! (($#)); then
        echo 'Warning: Input is not from a terminal. Forcing "view -".';
        args=('-');
    fi;
    command view "${args[@]}";
}

# Make Less The Default Pager, And Specify Some Useful Defaults.
less_options=(
    # If The Entire Text Fits On One Screen, Just Show It And Quit. ( Be More
    # Like "cat" And Less Like "more". )
    --quit-if-one-screen

    # Do Not Clear The Screen First.
    --no-init

    # Like "smartcase" In Vim: Ignore Case Unless The Search Pattern Is Mixed.
    --ignore-case

    # Do Not Automatically Wrap Long Lines.
    --chop-long-lines

    # Allow ANSI Colour Escapes, But No Other Escapes.
    --RAW-CONTROL-CHARS

    # Do Not Ring The Bell When Trying To Scroll Past The End Of The Buffer.
    --quiet

    # Do Not Complain When We Are On A Dumb Terminal.
    --dumb
);
export LESS="${less_options[*]}";
unset less_options;
export PAGER='less';

# Make "less" Transparently Unpack Archives Etc.
if [ -x /usr/bin/lesspipe ]; then
    eval $(/usr/bin/lesspipe);
elif command -v lesspipe.sh > /dev/null; then
    # MacPorts Recommended "/opt/local/bin/lesspipe.sh", But This Is More
    # Portable For People That Have It In Another Directory In Their $PATH.
    eval $(lesspipe.sh);
fi;

# Edit and reload the profile.
function pro {
    vi +3tabn -p ~/.bash_profile ~/.bash/{shell,commands,prompt,extra};
    source ~/.bash_profile;
}

# - - - - - - - - - - - - - - - - - - - -
# Autocompletion
# - - - - - - - - - - - - - - - - - - - -

# complete -d cd pushd rmdir;
# complete -u finger mail;
# complete -v set unset;
# complete -A command wtfis;
# [ -d ~/.bash/completion ] && for file in ~/.bash/completion/*; do
# 	[ -f "$file" ] && source "$file";
# done;
# unset file;


# - - - - - - - - - - - - - - - - - - - -
# Directory Listing
# - - - - - - - - - - - - - - - - - - - -

# Always Use Colour Output For "ls".
if [[ "$OSTYPE" =~ ^darwin ]]; then
    alias ls='command ls --color=auto';
    COLORFLAG="--color";
    export COLORFLAG;
    #export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx';
    export LSCOLORS='gxfxcxdxbxGxDxabagacad';
else
    alias ls='command ls --color=auto';
    COLORFLAG="--color"
    export COLORFLAG
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
fi;

# List All Files Colorized In Long Format.
#alias l="ls -lF ${COLORFLAG}"

# List All Files Colorized In Long Format, Excluding . And ..
#alias la="ls -lAF ${COLORFLAG}"

# List Only Directories.
#alias lsd="ls -lF ${COLORFLAG} | grep --color=never '^d'"

# Always Use Color Output For `ls`.
alias ls="command ls ${COLORFLAG}"


# - - - - - - - - - - - - - - - - - - - -
# ColorLS
# - - - - - - - - - - - - - - - - - - - -
alias l='colorls --gs --sd'
alias la='colorls -1A --sd --gs --report '
alias ll='colorls -lA --sd --gs --report '
alias lsd='colorls -1d --sd --gs --report '
alias lsf='colorls -1f --sd --gs --report '
alias lsg='colorls -A --sd --gs --report '
alias lst='colorls -A --sd --tree '


# - - - - - - - - - - - - - - - - - - - -
# Grep
# - - - - - - - - - - - - - - - - - - - -

# Always Enable Colored `grep` Output.
# Note: `grep_options="--color=auto"` Is Deprecated, Hence The Alias Usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# - - - - - - - - - - - - - - - - - - - -
# Misc. Uitlities
# - - - - - - - - - - - - - - - - - - - -

# Trim New Lines And Copy To Clipboard.
alias c="tr -d '\n' | pbcopy"

# Merge PDF Files, Preserving Hyperlinks.
# @Usage:
#   `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# Intuitive Map Function.
# @Example: To List All Directories That Contain A Certain File:
#   find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Url-Encode Strings.
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Get Week Number.
alias week='date +%V'


# - - - - - - - - - - - - - - - - - - - -
# Shell / Terminal
# - - - - - - - - - - - - - - - - - - - -

# Print Each Path Entry On A Separate Line.
alias path='echo -e ${PATH//:/\\n}'

# Reload The Shell (I.E. Invoke As A Login Shell).
alias reload='exec ${SHELL} -l'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# macOS Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# DNS + Network
# - - - - - - - - - - - - - - - - - - - -

# Flush Directory Service Cache.
alias flush="sudo killall -HUP mDNSResponder"

# IP Addresses.
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show Active Network Interfaces.
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# View HTTP Traffic.
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""


# - - - - - - - - - - - - - - - - - - - -
# Finder + Spotlight
# - - - - - - - - - - - - - - - - - - - -

# Ring The Terminal Bell, And Put A Badge On Terminal.app’s Dock Icon.
# (Useful When Executing Time-Consuming Commands)
alias badge="tput bel"

# Recursively Delete `.DS_store` Files.
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty The Trash On All Mounted Volumes And The Main Hdd.
# Also, Clear Apple’s System Logs To Improve Shell Startup Speed.
# Finally, Clear Download History From Quarantine. https://mths.be/bum.
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/Hide Hidden Files In Finder.
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/Show All Desktop Icons (Useful When Presenting).
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Disable Spotlight.
alias spotoff="sudo mdutil -a -i off";

# Enable Spotlight.
alias spoton="sudo mdutil -a -i on";


# - - - - - - - - - - - - - - - - - - - -
# System
# - - - - - - - - - - - - - - - - - - - -

# Clean Up LaunchServices To Remove Duplicates In The “open With” Menu.
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# macOS Has No `md5sum`, So Use `md5` As A Fallback.
command -v md5sum > /dev/null || alias md5sum="md5";

# macOS Has No `sha1sum`, So Use `shasum` As A Fallback.
command -v sha1sum > /dev/null || alias sha1sum="shasum";

# Canonical Hex Dump ( Some Systems Have This Symlinked ).
command -v hd > /dev/null || alias hd='hexdump -C';

# JavaScriptCore Repl.
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc";
[ -e "${jscbin}" ] && alias jsc='${jscbin}';
unset jscbin;

# Plistbuddy Alias, Because Sometimes `defaults` Just Doesn’t Cut It.
alias plistbuddy="/usr/libexec/PlistBuddy";


# - - - - - - - - - - - - - - - - - - - -
# Privacy & Security Hardening
# - - - - - - - - - - - - - - - - - - - -

# Firevault Memory Security
alias sleepsafe='sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25 standby 0 standbydelay 0';
alias sleepdefault='sudo pmset -a destroyfvkeyonstandby 0 hibernatemode 3 standby 1 standbydelay 10800';

# Enable / Disable Captive Portal
alias disablecaptiveportal='sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false';
alias enablecaptiveportal='sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool true';


# - - - - - - - - - - - - - - - - - - - -
# Software Updates
# - - - - - - - - - - - - - - - - - - - -

# Get macOS Software Updates, And Update Installed Ruby Gems, Homebrew, NPM, And Their Installed Packages.
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; sudo gem update --system; sudo gem update; sudo gem cleanup';


# - - - - - - - - - - - - - - - - - - - -
# AFK + Hibernate + Sleep + Suspend
# - - - - - - - - - - - - - - - - - - - -

# Lock The Screen ( When Going AFK ).
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend";


# - - - - - - - - - - - - - - - - - - - -
# Dock
# - - - - - - - - - - - - - - - - - - - -

# Add A "Spacer" To The Macos Dock.
alias adddockspacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}' && killall Dock";


# - - - - - - - - - - - - - - - - - - - -
# Volume Control
# - - - - - - - - - - - - - - - - - - - -

# Stuff I Never Really Use But Cannot Delete Either Because Of http://xkcd.com/530/.
alias stfu="osascript -e 'set volume output muted true'";
alias pumpitup="osascript -e 'set volume output volume 100'";

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Node Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# NPM
# - - - - - - - - - - - - - - - - - - - -

# Interactively Create A package.json File
alias npmnew='npm init'

# Interactively Create A package.json File ( Use Only Defaults And Not Prompt For Any Options )
alias npmnewf='npm init -f'

# Install Package / Dependencies
alias npmI='npm i'

# Install Package / Dependencies Globally
alias npmg='npm i -g'

# Install And Save To Dependencies In package.json
alias npmS='npm i -S'

# Install And Save To Dependencies In package.json With An Exact Version
alias npmSe='npm i -S -E'

# Install And Save To devDependencies In package.json
alias npmD='npm i -D'

# Install And Save To devDependencies In package.json With An Exact Version
alias npmDe='npm i -D -E'

# Install And Save To optionalDependencies In package.json
alias npmIo='npm i -O'

# Install And Save To optionalDependencies In package.json With An Exact Version
alias npmIoe='npm i -O -E'

# Update Package(s)
alias npmU='npm update'

# Update Package(s) Globally
alias npmUg='npm update -g'

# Uninstall Package / Dependencies
alias npmrm='npm rm'

# Uninstall Package / Dependencies Globally
alias npmrmg='npm rm -g'

# Uninstall And Remove From Dependencies In package.json
alias npmrms='npm rm -S'

# Uninstall And Remove From devDependencies In package.json
alias npmrmd='npm rm -D'

# Uninstall And Remove From optionalDependencies In package.json
alias npmrmo='npm rm -O'

# Remove Extraneous Packages
alias npmprn='npm prune'

# Check Which NPM Modules Are Outdated
alias npmO='npm outdated'

# Symlink A Package Folder
alias npmlnk='npm link'

# List Packages
alias npmL='npm list'

# List Packages ( Only First Level )
alias npmL0='npm list --depth=0'

# List Packages Globally
alias npmLg='npm list -g'

# List Packages Globally ( Only First Level )
alias npmLg0='npm list -g --depth=0'

# Publish A Package
alias npmP='npm publish'

# Search In The NPM Database
alias npmse='npm search'

# Create Shrinkwrap
alias npmsh='npm shrinkwrap'

# Run `npm start`
alias npmst='npm start'

# Run `npm test`
alias npmt='npm test'

# Run Custom NPM Script
alias npmR='npm run'

# Run `npm audit`
alias npmA='npm audit'

# Run `npm audit fix`
alias npmAf='npm audit fix'


# - - - - - - - - - - - - - - - - - - - -
# Remove Lock Files
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmrsh!='rm -rf ./npm-shrinkwrap.json ./package-lock.json'
alias npmrpl!='npmrsh!'


# - - - - - - - - - - - - - - - - - - - -
# Clear `node_modules` In Current Directory
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmclr!='rm -rf ./node_modules/'


# - - - - - - - - - - - - - - - - - - - -
# Reinstall Package
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmre!='npmclr! && npmI'


# - - - - - - - - - - - - - - - - - - - -
# Reinstall Package With `remove-create package-lock`
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmres!='npmclr! && npmrsh! && npmI'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Yarn Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Yarn
# - - - - - - - - - - - - - - - - - - - -

alias y='yarn'

# `yarn add`
alias ya='yarn add'
alias yad='yarn add --dev'
alias yap='yarn add --peer'

# `yarn build`
alias yb='yarn build'

# `yarn cache`
alias ycc='yarn cache clean'

# `yarn dev`
alias yd='yarn dev'

# `yarn global`
alias yga='yarn global add'
alias ygls='yarn global list --depth=0'
alias ygrm='yarn global remove'
alias ygu='yarn global upgrade'
alias ygui='yarn global upgrade-interactive';
alias yuc='yarn global upgrade && yarn cache clean'

# `yarn help`
alias yh='yarn help'

# `yarn init`
alias yi='yarn init'

# `yarn install`
alias yin='yarn install'

# `yarn lint`
alias yln='yarn lint'

# `yarn list`
alias yls='yarn list --depth=0'

# `yarn outdated`
alias yout='yarn outdated'

# `yarn pack`
alias yp='yarn pack'

# `yarn remove`
alias yrm='yarn remove'

# `yarn run`
alias yrun='yarn run'

# `yarn serve`
alias ys='yarn serve'

# `yarn start`
alias yst='yarn start'

# `yarn test`
alias yt='yarn test'
alias ytc='yarn test --coverage'

# `yarn upgrade`
alias yui='yarn upgrade-interactive'
alias yup='yarn upgrade'

# `yarn version`
alias yv='yarn version'

# `yarn workspace(s)`
alias yw='yarn workspace'
alias yws='yarn workspaces'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# DEV Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# Apache
# - - - - - - - - - - - - - - - - - - - -

# alias startapache="sudo brew services start httpd"
# alias stopapache="sudo brew services stop httpd"
# alias restartapache="sudo brew services restart -k httpd"
alias startapache="sudo apachectl start"
alias stopapache="sudo apachectl -k stop"
alias restartapache="sudo apachectl -k restart"


# - - - - - - - - - - - - - - - - - - - -
# Brew Graph
# - - - - - - - - - - - - - - - - - - - -

alias brew-deps="brew deps --installed"
#alias brew-graph="brew graph --installed | dot -tpng -ograph.png && open graph.png"
alias brew-graph="brew graph --installed --highlight-leaves | fdp -tpng -ograph.png && open graph.png"

# - - - - - - - - - - - - - - - - - - - -
# Git
# - - - - - - - - - - - - - - - - - - - -
alias gitdelete='git branch | egrep -v "(master|staging|develop|release_candidate\*)" | xargs git branch -D'

# - - - - - - - - - - - - - - - - - - - -
# Google Chrome
# - - - - - - - - - - - - - - - - - - - -

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# Kill All The Tabs In Chrome To Free Up Memory.
#alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"


# - - - - - - - - - - - - - - - - - - - -
# Dnsmasq
# - - - - - - - - - - - - - - - - - - - -

alias startdnsmasq="sudo brew services start dnsmasq"
alias stopdnsmasq="sudo brew services stop dnsmasq"
alias restartdnsmasq="sudo brew services restart dnsmasq"


# - - - - - - - - - - - - - - - - - - - -
# Mongo Database
# - - - - - - - - - - - - - - - - - - - -

#alias startmongo='mongod --dbpath ~/data/db --fork --logpath /dev/null'
#alias stopmongo='mongo admin --eval 'db.shutdownserver()' > /dev/null'


# - - - - - - - - - - - - - - - - - - - -
# MySQL Database
# - - - - - - - - - - - - - - - - - - - -

# MariaDB
#alias startmysql='brew services start mariadb'
#alias stopmysql='brew services stop mariadb'

# MySQL
alias startmysql='brew services start mysql'
alias stopmysql='brew services stop mysql'
alias restartmysql='brew services restart mysql'

# MySQL ( v5.7 )
alias startmysql57='brew services start mysql@5.7'
alias stopmysql57='brew services stop mysql@5.7'
alias restartmysql57='brew services restart mysql@5.7'


# - - - - - - - - - - - - - - - - - - - -
# PostgreSQL Database
# - - - - - - - - - - - - - - - - - - - -

alias startpostgres='brew services start postgresql'
alias stoppostgres='brew services stop postgresql'


# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -

alias sketchtool='$(mdfind kMDItemCFBundleIdentifier == "com.bohemiancoding.sketch3" | head -n 1)/Contents/Resources/sketchtool/bin/sketchtool'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Ruby Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# Bundler
# - - - - - - - - - - - - - - - - - - - -
alias bi='bundle install'
alias be='bundle exec '
alias bu='bundle update'
alias buc='bundle update --conservative'
alias bo='bundle open'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Docker Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

alias dkelc='docker exec -it `dklcid` bash'           # Enter Last Container ( Docker v1.3+ )
alias dki='docker images'                             # List Docker Images
alias dklc='docker ps -l'                             # List Last Docker Container
alias dklcid='docker ps -l -q'                        # List Last Docker Container ID
# Get IP Of Last Docker Container
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
alias dkps='docker ps'                                # List Running Docker Containers
alias dkpsa='docker ps -a'                            # List All Docker Containers
alias dkrmac='docker rm $(docker ps -a -q)'           # Delete All Docker Containers
alias dkrmlc='docker-remove-most-recent-container'    # Delete Most Recent Docker Container


# - - - - - - - - - - - - - - - - - - - -
# OS-Specific Image Cleanup
# - - - - - - - - - - - - - - - - - - - -
case $OSTYPE in
    darwin*|*bsd*|*BSD*)
        # Delete All Untagged Docker Images
        alias dkrmui='docker images -q -f dangling=true | xargs docker rmi'
        ;;
    *)
        # Delete All Untagged Docker Images
        alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'
        ;;
esac


# - - - - - - - - - - - - - - - - - - - -
# Cleanup All Docker Assets ( Containers + Images + Volumes )
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-all='docker container stop $(docker container ls -a -q) && \
          docker system prune -a -f --volumes'


# - - - - - - - - - - - - - - - - - - - -
# Cleanup Docker Containers
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-containers='docker container stop $(docker container ls -a -q) && \
          docker container rm $(docker container ls -a -q)'


# - - - - - - - - - - - - - - - - - - - -
# Cleanup Unused Docker Assets
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-unused='docker system prune --all --force --volumes'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Kubernetes Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Managing Multiple Aws Eks Clusters
# - - - - - - - - - - - - - - - - - - - -

alias eks-main-prod='export AWS_PROFILE=canvasprod && \
          aws eks update-kubeconfig --name prod-eks && \
          source <(kubectl completion bash)';

alias eks-main-int='export AWS_PROFILE=canvasprod && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash)';

alias eks-canvastest-int='export AWS_PROFILE=canvastest && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash)';

alias eks-canvastest-int-gc-dev='export AWS_PROFILE=canvastest && \
          aws eks update-kubeconfig --name int-eks && \
          source <(kubectl completion bash) && \
          kubectl config set-context $(kubectl config current-context) --namespace gc-dev';

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Personal Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Code Editor + IDE
# - - - - - - - - - - - - - - - - - - - -
# Open .zshrc To Be Edited In Vs Code
alias change='code-insiders ~/.zshrc'
# Re-Run Source Command On .zshrc To Update Current Terminal Session With New Settings
alias update='source ~/.zshrc'


# - - - - - - - - - - - - - - - - - - - -
# Rails
# - - - - - - - - - - - - - - - - - - - -
# Look For A Specific Line In `config_secure.yml` Across All Rails Applications In A Shared Web Instance.
get_rails_config() {
  # If No Argument For The Rails Environment Name Is Passed In, Display An Alert & Usage Example.
  if [ -z "${1}" ]; then
    echo -en "No Rails environment was specified!\n"
    echo
    echo -en "${bold}${violet}@USAGE:${reset}\n\t${yellow}$ get_rails_config [RAILS_ENV]\n"
    echo
    echo -en "${bold}${violet}@EXAMPLE:${reset}\n\t$ get_rails_config demo"
    echo
  else
    # Locally Scope These To Prevent Any Chance Of OS-Level Environment Variable Inheritance.
    local RAILS_ENV="${1}";
    local WEB_ROOT='/var/www/html';
    grep -H -R "${RAILS_ENV}:" "${WEB_ROOT}"/*/shared/system/config_secure.yml;
  fi
}


# - - - - - - - - - - - - - - - - - - - -
# Fun Stuff
# - - - - - - - - - - - - - - - - - - - -
alias rr='curl -s -L https://gist.githubusercontent.com/brucebentley/c3e854a922fffae785897ac442ab70b3/raw/452a47d06b3b47eb8ccd2c50684a02c008b46330/roll.sh | bash'

#
# aliases.zsh
#

alias reload!='. ~/.zshrc'

# Easier Navigation: .., ..., ...., ....., ~ And -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'    # `cd` Is Probably Faster To Type Though
alias -- -='cd -'

# Shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dr="cd ~/Dropbox"
alias dt="cd ~/Desktop"
alias p="cd ~/Projects"
alias s="cd ~/Sites"
alias g="git"
alias h="history"
alias j="jobs"

# Detect Which `ls` Flavor Is In Use
if ls --color > /dev/null 2>&1; then # Gnu `ls`
  colorflag="--color"
  export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
  colorflag="-G"
  export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List All Files Colorized In Long Format
alias l="ls -lF ${colorflag}"

# List All Files Colorized In Long Format, Including Dot Files
alias la="ls -laF ${colorflag}"

# List Only Directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always Use Color Output For `ls`
alias ls="command ls ${colorflag}"

# Always Enable Colored `grep` Output
#   @NOTE: `grep_options="--color=auto"` Is Deprecated, Hence The Alias Usage
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable Aliases To Be sudo’ed
alias sudo='sudo '

# Get Week Number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get Macos Software Updates, And Update Installed Ruby Gems, Homebrew, npm, And Their Installed Packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# IP Addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show Active Network Interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service Cache
alias flush="sudo killall -HUP mDNSResponder"

# Clean Up Launchservices To Remove Duplicates In The “open With” Menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View Http Traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical Hex Dump; Some Systems Have This Symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# Macos Has No `md5sum`, So Use `md5` As A Fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# Macos Has No `sha1sum`, So Use `shasum` As A Fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Javascriptcore Repl
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc";
[ -e "${jscbin}" ] && alias jsc="${jscbin}";
unset jscbin;

# Trim New Lines And Copy To Clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively Delete `.ds_store` Files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty The Trash On All Mounted Volumes And The Main Hdd
# Also, Clear Apple’s System Logs To Improve Shell Startup Speed
# Finally, Clear Download History From Quarantine
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide Hidden Files In Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show All Desktop Icons (useful When Presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-Encode Strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF Files
#   @USAGE: `mergepdf -o Output.pdf Input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Plistbuddy Alias, Because Sometimes `defaults` Just Doesn’t Cut It
alias plistbuddy="/usr/libexec/PlistBuddy"

# Ring The Terminal Bell, And Put A Badge On Terminal.app’s Dock Icon
alias badge="tput bel"

# Intuitive Map Function
# @EXAMPLE: To List All Directories That Contain A Certain File:
#             find . -name .gitattributes | Map Dirname
alias map="xargs -n1"

# One Of @janmoesen’s Protip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# Make Grunt Print Stack Traces By Default.
command -v grunt > /dev/null && alias grunt="grunt --stack"

# Stuff I Never Really Use But Cannot Delete Either Because Of Http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Kill All The Tabs In Chrome To Free Up Memory
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock The Screen (When Going afk)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload The Shell (i.e. Invoke As A Login Shell)
alias reload="exec $SHELL -l"

# Print Each Path Entry On A Separate Line
alias path='echo -e ${PATH//:/\\n}'


##################################################
# APPLICATIONS                                   #
##################################################
## START ANSIBLE
# alias startansible="pyenv shell 2.7.13 && source $python/personal/ansible/bin/activate";

## APACHE
alias startapache="sudo apachectl start"
alias stopapache="sudo apachectl -k stop"
alias restartapache="sudo apachectl -k restart"

## DNSMASQ
alias startdnsmasq="sudo brew services start dnsmasq"
alias stopdnsmasq="sudo brew services stop dnsmasq"

## GIT
alias gitdelete='git branch | egrep -v "(master|staging|develop|\*)" | xargs git branch -D'

## MONGO DATABASE
alias startmongo="mongod --dbpath ~/data/db --fork --logpath  /dev/null"
alias stopmongo="mongo admin --eval 'db.shutdownServer()' > /dev/null"

## MYSQL DATABASE
alias startmysql="brew services start mariadb"
alias stopmysql="brew services stop mariadb"

# POSTGRESQL DATABASE
alias startpostgres="brew services start postgresql"
alias stoppostgres="brew services stop postgresql"


##################################################
# FUNCTIONS                                      #
##################################################
## START CELERY
# alias startcelery="cd ~/projects/mbo/connect/connect-api &&
#     source ~/.virtualenvs/mbo/connect-api/bin/activate &&
#     mbo_env=development celery -a connect -l info worker";

### IMPORT MONGODB FOR CONNECT-API
# alias importmongo="
#     cd ~/dev/mbo/scripts/import_mongo &&
#     source $python/mbo/import_mongo/bin/activate &&
#     python db_import.py -f ~/downloads/connect-qa &&
#     deactivate";
# alias importconnectdata="importmongodb"


## GET AUTHENTICATION TOKENS FROM KEYCLOAK
### Associate
# alias associatetoken="getauthtoken blee@mbo-tst.com Mbo.2011 associate";
alias associatetoken="getAuthToken cclark1@mbo-tst.com Mbo.2011 associate";
# alias associatetoken="getauthtoken agreen@mbo-tst.com Mbo.2011 associate";
# alias associatetoken="getauthtoken sevans@mbo-tst.com Mbo.2011 associate";
# alias associatetoken="getauthtoken thansen@mbo-tst.com Mbo.2011 associate";

### Enterprise
alias enterprisetoken="getAuthToken blucas@mbo-tst.com Mbo.2015 enterprise";
# alias enterprisetoken="getauthtoken dcooke@mbo-tst.com Mbo.2015 enterprise";
# alias enterprisetoken="getauthtoken mcavaluzzi@mbo-tst.com Mbo.2015 enterprise";
# alias enterprisetoken="getauthtoken mlucero@mbo-tst.com Mbo.2015 enterprise";

### Enterprise Admin
alias entadmintoken="getAuthToken tberg@mbo-tst.com Mbo.2011 enterprise";


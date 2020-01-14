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


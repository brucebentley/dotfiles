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
alias nano="nano -w";
alias pico="nano";
alias vi="vim";
#export EDITOR="nvim";

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
    alias ls='command ls -G';
    COLORFLAG="-G";
    export COLORFLAG;
    export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx';
else
    alias ls='command ls --color=auto';
    COLORFLAG="--color"
    export COLORFLAG
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
fi;

# List All Files Colorized In Long Format.
alias l="ls -lF ${COLORFLAG}"

# List All Files Colorized In Long Format, Excluding . And ..
alias la="ls -lAF ${COLORFLAG}"

# List Only Directories.
alias lsd="ls -lF ${COLORFLAG} | grep --color=never '^d'"

# Always Use Color Output For `ls`.
alias ls="command ls ${COLORFLAG}"


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


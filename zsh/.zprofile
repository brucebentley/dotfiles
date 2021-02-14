#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# .zshenv
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

# Block Ads & Other Analytics
export HOMEBREW_NO_ANALYTICS=1      # Disable Homebrew analytics
export ADBLOCK=true
export DISABLE_OPENCOLLECTIVE=true
export DO_NOT_TRACK=1               # https://consoledonottrack.com/
export HOMEBREW_NO_ANALYTICS=1

# If It's Been More Than This Number Of Seconds Since Homebrew Was Last
# Updated, Automatically Run `brew update` Before `brew install`.
# 604800 = 1 week in seconds ( 60 * 60 * 24 * 7 )
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Always Cleanup After Installing Or Upgrading
export HOMEBREW_INSTALL_CLEANUP=1

# Disable Shell Sessions
export SHELL_SESSIONS_DISABLE=1

# Silent direnv
export DIRENV_LOG_FORMAT=""

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Export Environment Variables
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Term
#export TERM=rxvt-256color
export TERM=xterm-256color

# Editor
if [ "$(command -v nvim)" ]; then
    export EDITOR=nvim
    export VISUAL=nvim
elif [ "$(command -v vim)" ]; then
    export EDITOR=vim
    export VISUAL=vim
fi

# Pager
if [ "$(command -v less)" ]; then
    export MANPAGER=less
    export PAGER=less
elif [ "$(command -v more)" ]; then
    export MANPAGER=more
    export PAGER=more
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# XDG
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# See: https://0x46.net/thoughts/2019/02/01/dotfile-madness/
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="$HOME/.local/share"
export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_HOME"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$XDG_DATA_HOME"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Dotfiles Directory
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export DOTFILES="$HOME/dotfiles"
# [ -f $DOTFILES/install_config ] && source $DOTFILES/install_config

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Zsh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_EVALCACHE_DIR="$XDG_DATA_HOME/zsh"

export HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"   # History filepath
export HISTSIZE=10000000                        # Maximum events for internal history
export SAVEHIST=$HISTSIZE                       # Maximum events in history file

export _Z_DATA="$XDG_DATA_HOME/z/z.txt"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Git
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export GIT_REVIEW_BASE=master   # See gitconfig

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# GoLang
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export GO_HOME="$HOME/.go"
export GO_CACHE="$XDG_CACHE_HOME/go-build"

#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Homebrew
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export BREW_PREFIX="/usr/local"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# LESS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

#export LESS='-iFMRSX'
export LESSHISTFILE=/dev/null

export LESS_TERMCAP_mb=$(printf '\033[01;31m')
export LESS_TERMCAP_md=$(printf '\033[01;38;5;208m')
export LESS_TERMCAP_me=$(printf '\033[0m')
export LESS_TERMCAP_se=$(printf '\033[0m')
export LESS_TERMCAP_so=$(printf '\033[1;44;33m')
export LESS_TERMCAP_ue=$(printf '\033[0m')
export LESS_TERMCAP_us=$(printf '\033[04;38;5;111m')

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ls Colors
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.cfg=00;32:*.conf=00;32:*.diff=00;32:*.doc=00;32:*.ini=00;32:*.log=00;32:*.patch=00;32:*.pdf=00;32:*.ps=00;32:*.tex=00;32:*.txt=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Tmux
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#export TMUXP_CONFIGDIR="$XDG_CONFIG_HOME/tmuxp"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Vim
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export VIM_CONFIG="$XDG_CONFIG_HOME/vim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Wget
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# X11
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ASDF
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export ASDF_HOME="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$ASDF_HOME/.asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$ASDF_HOME/.tool-versions"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# AWS CLI
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set The Default AWS Profile To Use
export AWS_DEFAULT_PROFILE="default"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Composer
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Karabiner
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export KARABINER_HOME="$XDG_CONFIG_HOME/karabiner"
#export KARABINER_CONFIG_FILE="$KARABINER_HOME/karabiner.json"
export GOKU_EDN_CONFIG_FILE="$KARABINER_HOME/karabiner.edn"

# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -
export SKETCH_APP_CONTENTS="/Applications/Sketch.app/Contents"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Transmission
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export TRANSMISSION_HOME="$XDG_CONFIG_HOME/transmission"


{
    zcompare() {
        [ -s "$1" ] && [ ! -s "$1".zwc ] || \
        [ -n "$(find -L "$1" -prune -newer "$1".zwc 2>/dev/null)" ] && \
        zcompile -M "$1"
    }

    zcompare "${ZDOTDIR:-$HOME}/.zcompdump"
    zcompare "${ZDOTDIR:-$HOME}/.zprofile"
    zcompare "${ZDOTDIR:-$HOME}/.zshrc"

    for file in "${ZDOTDIR:-$HOME}/"**/*.{sh,zsh}; do
        zcompare "$file" 2>/dev/null
    done

    unfunction zcompare
} >/dev/null &! exec zsh


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Setup $PATH
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

# Unset $PATH
unset PATH

# No Duplicates In $PATH
typeset -U path
path=()

# On some other systems /usr/bin links to /bin; use the full path to prevent dupes.
_prepath() {
    for dir in "$@"; do
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        path=("$dir" $path[@])
    done
}
_postpath() {
    for dir in "$@"; do
        dir=${dir:A}
        [[ ! -d "$dir" ]] && return
        path=($path[@] "$dir")
    done
}

_prepath /bin /sbin /usr/bin /usr/sbin
_prepath "${BREW_PREFIX}/bin" "${BREW_PREFIX}/sbin"

_prepath "$HOME/.local/bin"
_prepath "$HOME/bin"

unfunction _prepath
unfunction _postpath

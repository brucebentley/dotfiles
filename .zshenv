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

# Pager
export PAGER=less

# Term
#export TERM=rxvt-256color
export TERM=xterm-256color

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

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
# Homebrew
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export BREW_PREFIX="/usr/local"

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
# ASDF
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export ASDF_HOME="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$ASDF_HOME/.asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$ASDF_HOME/.tool-versions"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Composer
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Git
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export GIT_REVIEW_BASE=master   # See gitconfig

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# GoLang
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export GO_HOME="$HOME/.go"
export GO_CACHE="$XDG_CACHE_HOME/go-build"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Karabiner
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export KARABINER_HOME="$XDG_CONFIG_HOME/karabiner"
#export KARABINER_CONFIG_FILE="$KARABINER_HOME/karabiner.json"
export GOKU_EDN_CONFIG_FILE="$KARABINER_HOME/karabiner.edn"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Transmission
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export TRANSMISSION_HOME="$XDG_CONFIG_HOME/transmission"

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
# AWS CLI
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set The Default AWS Profile To Use
#
# Available Profiles
#   - Default ( brucebentley )
#   - administrator@brucebentley
#   - bbentley
#   - canvastest
#   - optimizely
export AWS_DEFAULT_PROFILE="default"

# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -
export SKETCH_APP_CONTENTS="/Applications/Sketch.app/Contents"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# PATH
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# path=(
#     "$BREW_PREFIX/bin"
#     "$BREW_PREFIX/sbin"
#     "$HOME/.local/bin"
#     "$HOME/bin"
#     $path
# )

# - - - - - - - - - - - - - - - - - - - -
# Homebrew
# - - - - - - - - - - - - - - - - - - - -
# export PATH="$BREW_PREFIX/bin:$PATH"
# export PATH="$BREW_PREFIX/sbin:$PATH"

# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/bin:$PATH"

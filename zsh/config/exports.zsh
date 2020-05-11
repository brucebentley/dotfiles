
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Exports
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Initialize $PATH with system binaries
# - - - - - - - - - - - - - - - - - - - -

path=(
  "$HOME/.local/bin"
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  $path
)

# - - - - - - - - - - - - - - - - - - - -
# Platform Specific Variables
# - - - - - - - - - - - - - - - - - - - -
case $OSTYPE {
  darwin*)
  export GNU_COREUTILS_HOME='$(brew --prefix)/opt/coreutils/libexec/gnubin'
  export GNU_COREUTILS_MAN_HOME='$(brew --prefix)/opt/coreutils/libexec/gnuman'
  export GNU_FINDUTILS_HOME='$(brew --prefix)/opt/findutils/libexec/gnubin'
  export GNU_FINDUTILS_MAN_HOME='$(brew --prefix)/opt/findutils/libexec/gnuman'
  export GNU_GREP_HOME='$(brew --prefix grep)/libexec/gnubin'
  export GNU_GREP_MAN_HOME='$(brew --prefix grep)/libexec/gnuman'
  export OPENSSL_HOME='$(brew --prefix)/opt/openssl@1.1/bin'
  export OPENSSL_MAN_HOME='$(brew --prefix)/opt/openssl@1.1/man'
  export JAVA_HOME=/usr/libexec/java_home

  path=(
    $GNU_COREUTILS_HOME
    $GNU_FINDUTILS_HOME
    $GNU_GREP_HOME
    $OPENSSL_HOME
    $path
  )

  manpath=(
    $GNU_COREUTILS_MAN_HOME
    $GNU_FINDUTILS_MAN_HOME
    $GNU_GREP_MAN_HOME
    $OPENSSL_MAN_HOME
    $manpath
  )
  ;;
}

# Coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
# Findutils
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"
# GNU-Sed
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
# Grep
export PATH="$(brew --prefix grep)/libexec/gnubin:$PATH"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# CORE CONFIGURATION SETTINGS
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Default Editor
# - - - - - - - - - - - - - - - - - - - -
export EDITOR='nvim'

# - - - - - - - - - - - - - - - - - - - -
# BROWSER
# - - - - - - - - - - - - - - - - - - - -
#export BROWSER='xdg-open'

# - - - - - - - - - - - - - - - - - - - -
# GNUpg
# - - - - - - - - - - - - - - - - - - - -
# Avoid issues with `gpg` as installed via homebrew. See: https://stackoverflow.com/a/42265848/96656
GPG_TTY=$(tty)
export GPG_TTY
#gpgconf --launch gpg-agent
#export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

# - - - - - - - - - - - - - - - - - - - -
# Less
# - - - - - - - - - - - - - - - - - - - -
# export LESS=" \
#     --ignore-case \
#     --tilde \
#     --chop-long-lines \
#     --status-column \
#     --LONG-PROMPT \
#     --jump-target=10 \
#     --RAW-CONTROL-CHARS \
#     --clear-screen \
#     --silent \
#     --tabs=4 \
#     --shift=5"
# #export LESSOPEN="| highlight ${HIGHLIGHT_OPTIONS} -- %s 2>/dev/null"    # Use `highlight` program to try to highlight
#                                                                         # opened file according to its extension.
# export LESSHISTFILE="${HOME}/.config/less/lesshistory"                  # Command and search history file.
# export LESSKEYRC="${HOME}/.config/less/lesskey"                         # Path of the uncompiled lesskey file.
# export LESSKEY="${LESSKEYRC}.lwc"                                       # Path of the compiled lesskey file.
# export LESS_TERMCAP_md=$(tput bold; tput setaf 4)                       # Turn on bold mode.
# export LESS_TERMCAP_me=$(tput sgr0)                                     # Turn off all attributes.
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3)                       # Begin standout mode.
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                          # Exit standout mode.
# export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 250)          # Begin underline mode.
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                          # Exit underline mode.
# export LESS_TERMCAP_mr=$(tput rev)                                      # Turn on reverse video mode.
# export LESS_TERMCAP_mh=$(tput dim)                                      # Turn on half-bright mode.
# export LESS_TERMCAP_ZN=$(tput ssubm)                                    # Enter subscript mode.
# export LESS_TERMCAP_ZV=$(tput rsubm)                                    # End subscript mode.
# export LESS_TERMCAP_ZO=$(tput ssupm)                                    # Enter superscript mode.
# export LESS_TERMCAP_ZW=$(tput rsupm)                                    # End superscript mode.

# - - - - - - - - - - - - - - - - - - - -
# Locale
# - - - - - - - - - - - - - - - - - - - -
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

# - - - - - - - - - - - - - - - - - - - -
# MAN
# - - - - - - - - - - - - - - - - - - - -
export MANWIDTH='100' # Fixed line width for man pages
    if ([[ "$OSTYPE" =~ 'linux-android*' ]] 2>/dev/null) { MANWIDTH='50' }
export MANPAGER="nvim +'set filetype=man' -"
    if ([[ "$OSTYPE" =~ 'linux-android*' ]] 2>/dev/null) { unset MANPAGER }


# - - - - - - - - - - - - - - - - - - - -
# OpenSSL
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix wget)/bin:$PATH"

# Set The OpenSSL Directories To Use From Homebrew.
export LDFLAGS="-L$(brew --prefix)/opt/openssl@1.1/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/openssl@1.1/include"
# For Pkg-Config To Find Openssl You May Need To Set.
export PKG_CONFIG_PATH="$(brew --prefix)/opt/openssl@1.1/lib/pkgconfig"

# - - - - - - - - - - - - - - - - - - - -
# Default Pager
# - - - - - - - - - - - - - - - - - - - -
export PAGER='less'

# - - - - - - - - - - - - - - - - - - - -
# Term
# - - - - - - - - - - - - - - - - - - - -
export TERM='xterm-256color'

# - - - - - - - - - - - - - - - - - - - -
# Wget
# - - - - - - - - - - - - - - - - - - - -
export WGETRC="${HOME}/.config/wget/wgetrc"
export PATH="$(brew --prefix wget)/bin:$PATH"

# Set The Wget Directories To Use From Homebrew.
export LDFLAGS="-L$(brew --prefix wget)/lib"
export CPPFLAGS="-I$(brew --prefix wget)/include"
# For Pkg-Config To Find Wget You May Need To Set.
export PKG_CONFIG_PATH="$(brew --prefix wget)/lib/pkgconfig"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# DEV Essentials
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# NVM
# - - - - - - - - - - - - - - - - - - - -
# export NVM_DIR="$HOME/.nvm"

# - - - - - - - - - - - - - - - - - - - -
# Composer
# - - - - - - - - - - - - - - - - - - - -
export COMPOSER_HOME="${HOME}/.composer"
export PATH="${COMPOSER_HOME}/vendor/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# ImageMagick
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix)/opt/imagemagick@6/bin:$PATH"

# Set The Imagemagick Directories To Use From Homebrew.
export LDFLAGS="-L$(brew --prefix)/opt/imagemagick@6/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/imagemagick@6/include"
# For Pkg-Config To Find Imagemagick You May Need To Set.
export PKG_CONFIG_PATH="$(brew --prefix imagemagick@6)/lib/pkgconfig"

# - - - - - - - - - - - - - - - - - - - -
# Go
# - - - - - - - - - - - - - - - - - - - -
export GOPATH="$HOME/.go"
export PATH="$PATH:$(go env GOPATH)/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# MySQL
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix)/opt/mysql@5.7/bin:$PATH"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Environment Configuration
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# AWS CLI
# - - - - - - - - - - - - - - - - - - - -
# Set The Default AWS Profile To Use
#
# Available Profiles
#   - Default ( brucebentley )
#   - administrator
#   - bbentley
#   - canvas-test
#   - optimizely
export AWS_DEFAULT_PROFILE="default"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Utilities
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Prince
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix)/lib/prince/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -
export PATH="Sketch.app/Contents/Resources/sketchtool/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Transmission
# - - - - - - - - - - - - - - - - - - - -
export TRANSMISSION_HOME="${HOME}/.config/transmission"

################################################################################
#                                                                              #
# EXPORTS                                                                      #
#                                                                              #
################################################################################

##
# INITIALIZE $PATH WITH SYSTEM BINARIES
##
path=(
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    $path
)

##
# PLATFORM SPECIFIC VARIABLES
##
case $OSTYPE {
    darwin*)
        export GNU_COREUTILS_HOME='/usr/local/opt/coreutils/libexec/gnubin'
        export GNU_COREUTILS_MAN_HOME='/usr/local/opt/coreutils/libexec/gnuman'
        export GNU_FINDUTILS_HOME='/usr/local/opt/findutils/libexec/gnubin'
        export GNU_FINDUTILS_MAN_HOME='/usr/local/opt/findutils/libexec/gnuman'
        export OPENSSL_HOME='/usr/local/opt/openssl/bin'
        export OPENSSL_MAN_HOME='/usr/local/opt/openssl/man'
        export JAVA_HOME=$(/usr/libexec/java_home)

        path=(
            $GNU_COREUTILS_HOME
            $GNU_FINDUTILS_HOME
            $OPENSSL_HOME
            $path
        )

        manpath=(
            $GNU_COREUTILS_MAN_HOME
            $GNU_FINDUTILS_MAN_HOME
            $OPENSSL_MAN_HOME
            $manpath
        )
        ;;
}

##
# TERM
##
export TERM='xterm-256color'

##
# DEFAULT EDITOR
##
export EDITOR='nvim'

##
# DEFAULT PAGER
##
export PAGER='less'

##
# BROWSER
##
# export BROWSER='xdg-open'

##
# LOCALE
##
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

##
# MAN
##
export MANWIDTH='100' # Fixed line width for man pages
    if ([[ $OSTYPE =~ 'linux-android*' ]] 2>/dev/null) { MANWIDTH='50' }
export MANPAGER="nvim +'set filetype=man' -"
    if ([[ $OSTYPE =~ 'linux-android*' ]] 2>/dev/null) { unset MANPAGER }

##
# NODE
##
export NODE_REPL_HISTORY=~/.node_history # Enable persistent repl history for `node`
export NODE_REPL_HISTORY_SIZE='32768' # Allow 32³ entries; the default is 1000
export NODE_REPL_MODE='sloppy' # Use sloppy mode by default, matching web browsers
export NODE_OPTIONS=--max_old_space_size=4096 # Set node max cpu size

##
# NPM
##
export NPM_CONFIG_INIT_AUTHOR_NAME='Bruce Bentley'
export NPM_CONFIG_INIT_AUTHOR_EMAIL='bbentley@mbopartners.com'
export NPM_CONFIG_INIT_AUTHOR_URL='https://github.com/brucebentley'
export NPM_CONFIG_INIT_LICENSE='MIT'
export NPM_CONFIG_INIT_VERSION='0.0.0'
export NPM_CONFIG_SAVE_PREFIX='~'
export NPM_CONFIG_SIGN_GIT_TAG='true'

##
# NVIM
##
export NVIM_RPLUGIN_MANIFEST="$HOME/dotfiles/vim/cache/share/rplugin.vim"
# export NVIM_NODE_LOG_FILE="$HOME/dotfiles/vim/cache/log/node.log"
# export NVIM_NODE_LOG_LEVEL='4'

##
# GNUPG
##
export GPG_TTY=$(tty)

##
# WGET
##
export WGETRC="${HOME}/.config/wget/wgetrc"

##
# TRANSMISSION
##
export TRANSMISSION_HOME="${HOME}/.config/transmission"

##
# LESS
##
export LESS=" \
    --ignore-case \
    --tilde \
    --chop-long-lines \
    --status-column \
    --LONG-PROMPT \
    --jump-target=10 \
    --RAW-CONTROL-CHARS \
    --clear-screen \
    --silent \
    --tabs=4 \
    --shift=5"
# export LESSOPEN="| highlight ${HIGHLIGHT_OPTIONS} -- %s 2>/dev/null"    # Use `highlight` program to try to highlight
                                                                        # opened file according to its extension.
export LESSHISTFILE="${HOME}/.config/less/lesshistory"                  # Command and search history file.
export LESSKEYRC="${HOME}/.config/less/lesskey"                         # Path of the uncompiled lesskey file.
export LESSKEY="${LESSKEYRC}.lwc"                                       # Path of the compiled lesskey file.
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)                       # Turn on bold mode.
export LESS_TERMCAP_me=$(tput sgr0)                                     # Turn off all attributes.
export LESS_TERMCAP_so=$(tput bold; tput setaf 3)                       # Begin standout mode.
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                          # Exit standout mode.
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 250)          # Begin underline mode.
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                          # Exit underline mode.
export LESS_TERMCAP_mr=$(tput rev)                                      # Turn on reverse video mode.
export LESS_TERMCAP_mh=$(tput dim)                                      # Turn on half-bright mode.
export LESS_TERMCAP_ZN=$(tput ssubm)                                    # Enter subscript mode.
export LESS_TERMCAP_ZV=$(tput rsubm)                                    # End subscript mode.
export LESS_TERMCAP_ZO=$(tput ssupm)                                    # Enter superscript mode.
export LESS_TERMCAP_ZW=$(tput rsupm)                                    # End superscript mode.

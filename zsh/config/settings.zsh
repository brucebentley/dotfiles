# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Settings
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

##
# ENABLE Vi EMULATION FOR ZLE
##
# bindkey -v

##
# ZSH LINE EDITOR
##
# typeset -g zle_highlight=(region:bg=black) # Highlight the background of the text when selecting
# setopt NO_BEEP # Don't beep on errors

##
# CHANGING DIRECTORIES
##
# DIRSTACKSIZE=9 # The maximum size of the directory stack for `pushd` and `popd`
setopt AUTO_CD              # If can't execute the directory, perform the cd command to that
setopt AUTO_PUSHD           # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS    # Don't push multiple copies of the same directory onto the stack


# Automatically change directory if a directory is entered
setopt autocd




##
# COMPLETION
##
# zstyle ':completion:*' menu select # Use completion menu for completion when available
# zstyle ':completion:*' rehash true # When new programs is installed, auto update without reloading
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Match dircolors with completion schema
# setopt COMPLETE_ALIASES # Prevent aliases from being substituted before completion is attempted
# setopt COMPLETE_IN_WORD # Attempt to start completion from both ends of a word
# setopt GLOB_COMPLETE # Don't insert anything resulting from a glob pattern, show completion menu
# setopt MENU_COMPLETE # Instead of listing possibilities, select the first match immediately

##
# EXPANSION AND GLOBBING
##
# setopt BRACE_CCL # Expand expressions in braces which would not otherwise undergo brace expansion
case_glob
setopt extendedglob      # Treat the `#`, `~` and `^` characters as part of patterns for globbing
setopt globdots          # Don't require a leading '.' in a filename to be matched explicitly
# setopt MARK_DIRS # Append a trailing `/` to all directory names resulting from globbing
# setopt NO_NOMATCH # If a pattern has no matches, don't print an error, leave it unchanged
# setopt WARN_CREATE_GLOBAL # Warn when a global variables is created in a function
# # setopt WARN_NESTED_VAR # Warn when an existing variables from an outer scope is set in a function

##
# HISTORY
##
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory notify
unsetopt beep nomatch

setopt appendhistory notify       #
setopt bang_hist                  # Treat the '!' character specially during expansion.
setopt inc_append_history         # Write to the history file immediately, not when the shell exits.
setopt share_history              # Share history between all sessions.
setopt hist_expire_dups_first     # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups           # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups       # Delete an old recorded event if a new event is a duplicate.
setopt hist_find_no_dups          # Do not display a previously found event.
setopt hist_ignore_space          # Do not record an event starting with a space.
setopt hist_save_no_dups          # Do not write a duplicate event to the history file.
setopt hist_verify                # Do not execute immediately upon history expansion.
setopt extended_history


HISTFILE="$HOME/.zsh_history"     # Where history logs are stored
HISTSIZE=50000                    # The maximum number of events stored in the internal history list
SAVEHIST=10000                    # The maximum number of history events to save in the history file
#setopt BANG_HIST                 # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY           # Save each command's epoch timestamps and the duration in seconds
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicate entries first when trimming history
#setopt HIST_FIND_NO_DUPS         # Don't display a line previously found
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_DUPS           # Don't record an entry that was just recorded again
setopt HIST_IGNORE_SPACE          # Don't record an entry starting with a space
#setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording an entry
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
#setopt HIST_VERIFY               # Don't execute the line directly instead perform history expansion
setopt INC_APPEND_HISTORY         # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY              # Share history between all sessions

##
# INPUT/OUTPUT
##
# KEYTIMEOUT=10 # The time the shell waits, for another key to be pressed in milliseconds
# setopt NO_CLOBBER # Don't allow `>` redirection to override existing files. Use `>!` instead
# setopt NO_FLOW_CONTROL # Disable flow control characters `^S` and `^Q`
# setopt INTERACTIVE_COMMENTS # Allow comments even in interactive shells
# setopt RM_STAR_WAIT # Before executing `rm *` first wait 10 seconds and ignore anything typed

##
# JOB CONTROL
##
# setopt LONG_LIST_JOBS # Display PID when suspending processes as well

#
# config.zsh
#

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($ZSH/functions $fpath)

autoload -U $ZSH/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE                          # DON'T NICE BACKGROUND TASKS
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS                       # ALLOW FUNCTIONS TO HAVE LOCAL OPTIONS
setopt LOCAL_TRAPS                         # ALLOW FUNCTIONS TO HAVE LOCAL TRAPS
setopt HIST_VERIFY
setopt SHARE_HISTORY                       # SHARE HISTORY BETWEEN SESSIONS ???
setopt EXTENDED_HISTORY                    # ADD TIMESTAMPS TO HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY                      # ADDS HISTORY
setopt INC_APPEND_HISTORY SHARE_HISTORY    # ADDS HISTORY INCREMENTALLY AND SHARE IT ACROSS SESSIONS
setopt HIST_IGNORE_ALL_DUPS                # DON'T RECORD DUPES IN HISTORY
setopt HIST_REDUCE_BLANKS

# Don't Expand Aliases _before_ Completion Has Finished
#   @EXAMPLE: git comm-[tab]
setopt complete_aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char


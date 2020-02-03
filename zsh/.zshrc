#!usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - -
# Profiling Tools
# - - - - - - - - - - - - - - - - - - - -
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/startlog.$$
    setopt xtrace prompt_subst
fi

# - - - - - - - - - - - - - - - - - - - -
# Instant Prompt
# - - - - - - - - - - - - - - - - - - - -
# Enable Powerlevel10k instant prompt. Should stay close to the top of `~/.zshrc`.
# Initialization code that may require console input ( password prompts, [y/n]
# confirmations, etc. ) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# - - - - - - - - - - - - - - - - - - - -
# Homebrew Configuration
# - - - - - - - - - - - - - - - - - - - -
# If You Come From Bash You Might Have To Change Your $PATH.
# export PATH=:/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Homebrew Requires This.
export PATH="/usr/local/sbin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Zsh Core Configuration
# - - - - - - - - - - - - - - - - - - - -
# Install Functions.
export XDG_CONFIG_HOME="$HOME/.config"
export UPDATE_INTERVAL=15

export DOTFILES="$HOME/dotfiles"
export ZSH="$HOME/dotfiles/zsh"

export CACHEDIR="$HOME/.local/share"
[[ -d "$CACHEDIR" ]] || mkdir -p "$CACHEDIR"

# Load The Prompt System And Completion System And Initilize Them.
autoload -Uz compinit promptinit

# Load And Initialize The Completion System Ignoring Insecure Directories With A
# Cache Time Of 20 Hours, So It Should Almost Always Regenerate The First Time A
# Shell Is Opened Each Day.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files
promptinit
setopt prompt_subst

# - - - - - - - - - - - - - - - - - - - -
# Zplugin Configuration
# - - - - - - - - - - - - - - - - - - - -
if [[ ! -d $HOME/.zplugin/bin ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing Zplugin…%f"
    command mkdir -p "$HOME/.zplugin"
    command git clone https://github.com/zdharma/zplugin "$HOME/.zplugin/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi
. "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# - - - - - - - - - - - - - - - - - - - -
# ZSH Settings
# - - - - - - - - - - - - - - - - - - - -
autoload -U colors && colors    # Load Colors.
unsetopt case_glob              # Use Case-Insensitve Globbing.
setopt globdots                 # Glob Dotfiles As Well.
setopt extendedglob             # Use Extended Globbing.
setopt autocd                   # Automatically Change Directory If A Directory Is Entered.

# Smart URLs.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# General.
setopt brace_ccl                # Allow Brace Character Class List Expansion.
setopt combining_chars          # Combine Zero-Length Punctuation Characters ( Accents ) With The Base Character.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt mail_warning           # Don't Print A Warning Message If A Mail File Has Been Accessed.

# Jobs.
setopt long_list_jobs           # List Jobs In The Long Format By Default.
setopt auto_resume              # Attempt To Resume Existing Job Before Creating A New Process.
setopt notify                   # Report Status Of Background Jobs Immediately.
unsetopt bg_nice                # Don't Run All Background Jobs At A Lower Priority.
unsetopt hup                    # Don't Kill Jobs On Shell Exit.
unsetopt check_jobs             # Don't Report On Jobs When Shell Exit.

setopt correct                  # Turn On Corrections

# Completion Options.
setopt complete_in_word         # Complete From Both Ends Of A Word.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt auto_menu                # Show Completion Menu On A Successive Tab Press.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_param_slash         # If Completed Parameter Is A Directory, Add A Trailing Slash.
setopt no_complete_aliases

setopt menu_complete            # Do Not Autoselect The First Completion Entry.
unsetopt flow_control           # Disable Start/Stop Characters In Shell Editor.

# Zstyle.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true

# History.
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=100000
SAVEHIST=5000
setopt appendhistory notify
unsetopt beep nomatch

setopt bang_hist                # Treat The '!' Character Specially During Expansion.
setopt inc_append_history       # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history            # Share History Between All Sessions.
setopt hist_expire_dups_first   # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups         # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups     # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups        # Do Not Display A Previously Found Event.
setopt hist_ignore_space        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups        # Do Not Write A Duplicate Event To The History File.
setopt hist_verify              # Do Not Execute Immediately Upon History Expansion.
setopt extended_history         # Show Timestamp In History.

# - - - - - - - - - - - - - - - - - - - -
# User Configuration
# - - - - - - - - - - - - - - - - - - - -
setopt no_beep
# export MANPATH="/usr/local/man:$MANPATH"

# Load Custom Executable Functions
# [[ -f "$ZSH/config/functions.zsh" ]] && source "$ZSH/config/functions.zsh"

# Local Config
# [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

foreach piece (
    exports.zsh
    node.zsh
    aliases.zsh
    functions.zsh
) {
    source $ZSH/config/$piece
}

# - - - - - - - - - - - - - - - - - - - -
# Plugins
# - - - - - - - - - - - - - - - - - - - -
# Most Themes Use This Option.
setopt promptsubst

# OMZ Themes Use This Library.
zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh
# Load Two Oh My ZSH Files As Snippets, In Turbo:
zplugin wait lucid for \
    OMZ::lib/git.zsh \
    OMZ::plugins/git/git.plugin.zsh

# Set OMZ Theme.
PS1="READY >"    # Provide A Nice Prompt Till The Theme Loads.
zplugin ice wait'!' lucid
zplugin ice depth=1; zplugin light romkatv/powerlevel10k

# Example Functional Plugin.
zplugin ice wait lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/rbenv/rbenv.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/pyenv/pyenv.plugin.zsh

# Load Docker Completion.
zplugin ice wait as"completion" lucid
zplugin snippet OMZ::plugins/docker/_docker

zplugin ice wait blockf atpull'zplugin creinstall -q .'
zplugin light zsh-users/zsh-completions

zplugin ice wait atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

# Will use the array's value at the moment of plugin load
# – this can matter in case of using Turbo mode
array=( {exports,node,aliases,functions}.zsh )
zplugin ice svn multisrc"$ZSH/config/$array" pick"/dev/null"

# - - - - - - - - - - - - - - - - - - - -
# cdr, persistent cd
# - - - - - - - - - - - - - - - - - - - -
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
DIRSTACKFILE="$HOME/.cache/zsh/dirs"

# Make `DIRSTACKFILE` If It 'S Not There.
if [[ ! -a $DIRSTACKFILE ]]; then
    mkdir -p $DIRSTACKFILE[0,-5]
    touch $DIRSTACKFILE
fi

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
fi

chpwd() {
    print -l $PWD ${(u)dirstack} >>$DIRSTACKFILE
    local d="$(sort -u $DIRSTACKFILE )"
    echo "$d" > $DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt auto_pushd pushd_silent pushd_to_home

setopt pushd_ignore_dups        # Remove Duplicate Entries
setopt pushd_minus              # This Reverts The +/- Operators.

# - - - - - - - - - - - - - - - - - - - -
# Theme / Prompt Customization
# - - - - - - - - - - - - - - - - - - - -
# To Customize Prompt, Run `p10k configure` Or Edit `~/.p10k.zsh`.
[[ ! -f ~/.p10k.zsh ]] || . ~/.p10k.zsh

# - - - - - - - - - - - - - - - - - - - -
# End Profiling Script
# - - - - - - - - - - - - - - - - - - - -
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
    zprof > ~/zshprofile$(date +'%s')
fi

#
# If You Come From Bash You Might Have To Change Your $PATH.
#
# export PATH=$HOME/bin:/usr/local/bin:$PATH


##################################################
# GENERAL                                        #
##################################################
## Shortcut To This Dotfiles Path Is $zsh.
export ZSH=$HOME/dotfiles

## Your Project Folder That We Can `c [tab]` To.
export PROJECTS=~/Projects

## Set Name Of The Theme To Load. Optionally, If You Set This To "random"
## It'll Load A Random Theme Each Time That Oh-my-zsh Is Loaded.
##   @URL: https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="agnoster"


##################################################
# DOTFILES                                       #
##################################################
## Stash Your Environment Variables In `~/.localrc`. This Means They'll Stay Out
## Of Your Main Dotfiles Repository (which May Be Public, Like This One), But
## You'll Have Access To Them In Your Scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

## Load The Shell Dotfiles.
typeset -U config_files
config_files=($ZSH/**/*.zsh)

## Load The Path Files.
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

## Load Everything But The Path And Completion Files.
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

## Initialize Autocomplete Here, Otherwise Functions Won't Be Loaded.
autoload -U compinit
compinit

## Load Every Completion After Autocomplete Loads.
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files


##################################################
# MISC. CONFIGURATION SETTINGS                   #
##################################################
## Enable Command Auto-correction.
ENABLE_CORRECTION="true"

## Display Red Dots Whilst Waiting For Completion.
COMPLETION_WAITING_DOTS="true"

## Change The Command Execution Time Stamp Shown In The History Command Output.
##   @AVAILABLE FORMATS: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

## Do Not Overwrite Files When Redirecting Using ">".
##   @NOTE: You Can Still Override This With ">|"
set -o noclobber

## Preferred Editor For Local And Remote Sessions.
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nano'
else
    export EDITOR='subl'
fi

## Better History.
##  @CREDIT: https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # UP
bindkey "^[[B" down-line-or-beginning-search  # DOWN


##################################################
# PLUGINS                                        #
##################################################
## Which Plugins Would You Like To Load? (Plugins Can Be Found In ~/dotfiles/zsh/plugins/*)
## Custom Plugins May Be Added To `~/dotfiles/zsh/plugins/`
## Add Wisely, As Too Many Plugins Slow Down Shell Startup.
##
##   @EXAMPLE: Plugins=(rails Git Textmate Ruby Lighthouse)
##
plugins=(git git-flow history zsh-syntax-highlighting)


##################################################
# NVM                                            #
##################################################
## Automatically Activate `nvm` (When Available).
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


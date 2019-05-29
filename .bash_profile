#
# ~/.bash_profile
#

##
# ADD `~/bin` TO THE `$PATH`.
##
export PATH="$HOME/bin:$PATH";

source "$HOME/bin/nerd-fonts/i_all.sh";

##
# LOAD THE SHELL DOTFILES, AND THEN SOME:
#   ~/.path CAN BE USED TO EXTEND `$PATH`.
#   ~/.extra CAN BE USED FOR OTHER SETTINGS YOU DON'T WANT TO COMMIT.
##
for file in ~/dotfiles/.{path,bash_prompt,exports,aliases,functions,extra,profile}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

##
# CASE-INSENSITIVE GLOBBING (USED IN PATHNAME EXPANSION).
##
shopt -s nocaseglob;

##
# APPEND TO THE BASH HISTORY FILE, RATHER THAN OVERWRITING IT.
##
shopt -s histappend;

##
# AUTOCORRECT TYPOS IN PATH NAMES WHEN USING `cd`.
##
shopt -s cdspell;

##
# ENABLE SOME BASH 4 FEATURES WHEN POSSIBLE:
#   `autocd`, E.G. `**/qux` WILL ENTER `./foo/bar/baz/qux`
#   RECURSIVE GLOBBING, e.g. `echo **/*.txt`
##
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

##
# ADD TAB COMPLETION FOR MANY BASH COMMANDS.
##
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    # ENSURE EXISTING HOMEBREW v1 COMPLETIONS CONTINUE TO WORK.
    export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

##
# ENABLE TAB COMPLETION FOR `g` BY MARKING IT AS AN ALIAS FOR `git`.
##
if type _git &> /dev/null && [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
    complete -o default -o nospace -F _git g;
fi;

##
# ADD TAB COMPLETION FOR SSH HOSTNAMES BASED ON ~/.ssh/config, IGNORING WILDCARDS.
##
function __completeSSHHosts {
    COMPREPLY=()
    local currentWord=${COMP_WORDS[COMP_CWORD]}
    local completeHosts=$(
      cat "$HOME/.ssh/config" | \
        grep --extended-regexp "^Host +([^* ]+ +)*[^* ]+ *$" | \
        tr -s " " | \
        sed -E "s/^Host +//"
    )

    COMPREPLY=($(compgen -W "$completeHosts" -- "$currentWord"))
    return 0
}
complete -F __completeSSHHosts ssh

##
# ADD TAB COMPLETION FOR `defaults read|write nsglobaldomain`
# YOU COULD JUST USE `-g` INSTEAD, BUT I LIKE BEING EXPLICIT.
##
complete -W "NSGlobalDomain" defaults;

##
# ADD `killall` TAB COMPLETION FOR COMMON APPS.
##
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall;


################################################################################
#
# iTerm
#
################################################################################

##
# THIS WILL SET YOUR WINDOW TITLE.
##
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

##
# iTerm SHELL INTEGRATION.
##
test -e "$HOME/.iterm2_shell_integration.bash" && source ~/.iterm2_shell_integration.`basename $SHELL`
#!/usr/bin/env bash

##
# SET CUSTOM iTerm2 USER VARIABLES.
##
function iterm2_print_user_vars() {
    iterm2_set_user_var badge $(dir_badges)
}

##
# CUSTOM BADGES ON A DIRECTORY-BY-DIRECTOY BASIS, DEFINED IN `~/dotfiles/.badges`.
##
function dir_badges() {
    while read directory badge || [[ -n "$directory" ]]
    do
        if [[ "$PWD" == $directory* ]]; then
            echo "$badge"
            break
        fi
    done < ~/dotfiles/.badges
}

################################################################################
#
# GOOGLE CLOUD PLATFORM
#
################################################################################
##
# THE NEXT LINE UPDATES PATH FOR THE GOOGLE CLOUD SDK.
##
if [ -f "$HOME/.google/cloud-sdk/path.bash.inc" ]; then source "$HOME/.google/cloud-sdk/path.bash.inc"; fi

##
# THE NEXT LINE ENABLES SHELL COMMAND COMPLETION FOR GCLOUD.
##
if [ -f "$HOME/.google/cloud-sdk/completion.bash.inc" ]; then source "$HOME/.google/cloud-sdk/completion.bash.inc"; fi


################################################################################
#
# NVM
#
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                    # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##
# Change Title Name Of Tab In Terminal.
##
function title {
    echo -ne "\033]0;"$*"\007"
}

##
# Check For A `.nvmrc` File When Entering A Directory, Then
# Automatically Activate The Required Version Of NodeJS. If The
# Required Version Is Not Currently Installed, It Will Download,
# Install & Activate The Correct Version For You.
##
cd () {
  builtin cd "$@" && chNodeVersion;
}
pushd () {
  builtin pushd "$@" && chNodeVersion;
}
popd () {
  builtin popd "$@" && chNodeVersion;
}

chNodeVersion() {
  local NODE_VERSION="$(nvm version)"
  local NVMRC_PATH="$(nvm_find_nvmrc)"

  if [ -n "$NVMRC_PATH" ]; then
    local NVMRC_NODE_VERSION=$(nvm version "$(cat "${NVMRC_PATH}")")

    if [ "$NVMRC_NODE_VERSION" = "N/A" ]; then
      echo -e "${bold}${yellow}—[ WARNING ]— Required version NodeJS is not currently installed. ${green}Downloading Now!${reset}";
      nvm install
    elif [ "$NVMRC_NODE_VERSION" != "$NODE_VERSION" ]; then
      nvm use
    fi
  elif [ "$NODE_VERSION" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
chNodeVersion;


################################################################################
#
# TRAVIS CI
#
################################################################################

##
# ADDED BY TRAVIS GEM.
##
#[ -f /Users/bbentley/.travis/travis.sh ] && source /Users/bbentley/.travis/travis.sh


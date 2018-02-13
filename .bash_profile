#
# ~/.bash_profile
#

# ADD `~/bin` TO THE `$PATH`
export PATH="$HOME/bin:$PATH";

# LOAD THE SHELL DOTFILES, AND THEN SOME:
## * ~/.path CAN BE USED TO EXTEND `$PATH`.
## * ~/.extra CAN BE USED FOR OTHER SETTINGS YOU DON'T WANT TO COMMIT.
for file in ~/dotfiles/.{path,bash_prompt,exports,aliases,functions,extra,profile}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# CASE-INSENSITIVE GLOBBING (USED IN PATHNAME EXPANSION)
shopt -s nocaseglob;

# APPEND TO THE BASH HISTORY FILE, RATHER THAN OVERWRITING IT
shopt -s histappend;

# AUTOCORRECT TYPOS IN PATH NAMES WHEN USING `cd`
shopt -s cdspell;

# ENABLE SOME BASH 4 FEATURES WHEN POSSIBLE:
## * `autocd`, E.G. `**/qux` WILL ENTER `./foo/bar/baz/qux`
## * RECURSIVE GLOBBING, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# ADD TAB COMPLETION FOR MANY BASH COMMANDS
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# ENABLE TAB COMPLETION FOR `g` BY MARKING IT AS AN ALIAS FOR `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# ADD TAB COMPLETION FOR SSH HOSTNAMES BASED ON ~/.ssh/config, IGNORING WILDCARDS
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# ADD TAB COMPLETION FOR `defaults read|write nsglobaldomain`
# YOU COULD JUST USE `-g` INSTEAD, BUT I LIKE BEING EXPLICIT
complete -W "NSGlobalDomain" defaults;

# ADD `killall` TAB COMPLETION FOR COMMON APPS
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;


##################################################
# iTerm2                                         #
##################################################
### THIS WILL SET YOUR WINDOW TITLE.
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# iTerm SHELL INTEGRATION.
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
# source ~/.iterm2_shell_integration.`basename $SHELL`


##################################################
# ChefDK                                         #
##################################################
# eval "$(chef shell-init bash)";


##################################################
# GOOGLE CLOUD PLATFORM                          #
##################################################
## THE NEXT LINE UPDATES PATH FOR THE GOOGLE CLOUD SDK.
if [ -f "$HOME/.google/cloud-sdk/path.bash.inc" ]; then source "$HOME/.google/cloud-sdk/path.bash.inc"; fi

## THE NEXT LINE ENABLES SHELL COMMAND COMPLETION FOR GCLOUD.
if [ -f "$HOME/.google/cloud-sdk/completion.bash.inc" ]; then source "$HOME/.google/cloud-sdk/completion.bash.inc"; fi



##################################################
# NVM                                            #
##################################################
## Add Tab Completion For nvm Commands.
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

## Change Title Name Of Tab In Terminal..
function title {
    echo -ne "\033]0;"$*"\007"
}

## Check For A `.nvmrc` File When Entering A Directory, Then
## Automatically Activate The Required Version Of NodeJS. If The
## Required Version Is Not Currently Installed, It Will Download,
## Install & Activate The Correct Version For You.
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

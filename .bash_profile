#
# ~/.bash_profile
#

# ADD `~/bin` TO THE `$PATH`
export PATH="$HOME/bin:$PATH";

# LOAD THE SHELL DOTFILES, AND THEN SOME:
## * ~/.path CAN BE USED TO EXTEND `$PATH`.
## * ~/.extra CAN BE USED FOR OTHER SETTINGS YOU DON'T WANT TO COMMIT.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
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

## SHELL INTEGRATION
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
source ~/.iterm2_shell_integration.`basename $SHELL`

### THIS CREATES THE VAR CURRENTDIR TO USE LATER ON.
# function iterm2_print_user_vars() {
#   iterm2_set_user_var currentDir $(echo ${PWD##*/})
# }

function iterm2_print_user_vars() {
    iterm2_set_user_var currentDir $(echo ${PWD##*/})
}


##################################################
# Visual Studio Code                             #
##################################################
### RUN VSCODE FROM THE TERMINAL



##################################################
# ChefDK                                         #
##################################################
# eval "$(chef shell-init bash)";



##################################################
# NVM                                            #
##################################################
# ADD TAB COMPLETION FOR NVM COMMANDS
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# CHANGE TITLE NAME OF TAB IN TERMINAL.
function title {
    echo -ne "\033]0;"$*"\007"
}

cd() {
  builtin cd "$@" || return
  # echo $PREV_PWD
  if [ "$PWD" != "$PREV_PWD" ]; then
    PREV_PWD="$PWD";
    title $(echo ${PWD##*/}) $(node -v);
    if [ -e ".nvmrc" ]; then
      nvm use;
      # SET TAB TERMINAL NAME TO BE `cwd` AND `node version`.
      title $(echo ${PWD##*/}) $(node -v);
    else
      nvm use default;
    fi
  fi
}

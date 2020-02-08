# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Ruby Configuration
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# `rbenv` — Ruby Environment Manager
# - - - - - - - - - - - - - - - - - - - -

zinit ice atclone'RBENV_ROOT="$HOME/.rbenv" ./libexec/rbenv init - > zrbenv.zsh' \
    atinit'export RBENV_ROOT="$HOME/.rbenv"' atpull"%atclone" \
    as'command' pick'bin/rbenv' src"zrbenv.zsh" nocompile'!'
zinit light rbenv/rbenv

# # Load rbenv ( If Available )
# if (( $+commands[rbenv] )) ; then
#     eval "$(rbenv init -)";

#     export RBENV_ROOT="$HOME/.rbenv";   # For `rbenv`
#     PATH="$RBENV_ROOT/bin:$PATH";       # For Custom Scripts
# fi;

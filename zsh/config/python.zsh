# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Python Configuration
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# `rbenv` — Python Environment Manager
# - - - - - - - - - - - - - - - - - - - -

zinit ice atclone'PYENV_ROOT="$HOME/.pyenv" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$HOME/.pyenv"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

# # Load pyenv ( If Available )
# if (( $+commands[pyenv] )) ; then
#     eval "$(pyenv init -)";
#     eval "$(pyenv virtualenv-init -)";

#     export PYENV_ROOT="$HOME/.pyenv";   # FOR `pyenv`
#     PATH="$PYENV_ROOT/bin:$PATH";       # For Custom Scripts
# fi;

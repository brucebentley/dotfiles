#
# ~/.bashrc
#

[ -n "$PS1" ] && source ~/.bash_profile;

##
# PIP SHOULD ONLY RUN IF THERE IS A VIRTUALENV CURRENTLY ACTIVATED.
##
export PIP_REQUIRE_VIRTUALENV=true;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

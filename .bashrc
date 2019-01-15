#
# ~/.bashrc
#

[ -n "$PS1" ] && source ~/.bash_profile;

# Pip SHOULD ONLY RUN IF THERE IS A VIRTUALENV CURRENTLYA CTIVATE
export PIP_REQUIRE_VIRTUALENV=true;

# SETTING VARIABLES FOR `Go` INSTALLATION — `aws-cli`
#export GOPATH="$HOME/bin/go/go"
#export GOROOT="/usr/local/opt/go/libexec"
#export PATH="$PATH:$GOPATH/bin"
#export PATH="$PATH:$GOROOT/bin"


# ##################################################
# # INITIALIZE `nvm`                               #
# ##################################################
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


# ADDED BY TRAVIS GEM
#[ -f /Users/bbentley/.travis/travis.sh ] && source /Users/bbentley/.travis/travis.sh

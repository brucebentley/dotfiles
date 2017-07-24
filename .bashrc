#
# ~/.bashrc
#

[ -n "$PS1" ] && source ~/.bash_profile;

# Pip SHOULD ONLY RUN IF THERE IS A VIRTUALENV CURRENTLYA CTIVATE
export PIP_REQUIRE_VIRTUALENV=true;

# SETTING VARIABLES FOR `Go` INSTALLATION — `aws-cli`
export GOPATH="$HOME/bin/go/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin"

# SETTING VARIABLES FOR RANCHER — `rancher-compose` CLI
#export RANCHER_URL="http://docker-mgmt.mbopartners.com:8080/v1/projects/1a43"
#export RANCHER_ACCESS_KEY="0F697B3E45C5D6ACE0AB"
#export RANCHER_SECRET_KEY="bcaZWu5xwq8mHXxUDeqWKWFnK2bTduRaWm1Gid93"


##################################################
# INITIALIZE `nvm`                               #
##################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"


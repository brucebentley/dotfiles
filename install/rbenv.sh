#!/usr/bin/env bash

# MAKE SURE WE’RE USING THE LATEST HOMEBREW.
brew update

# UPGRADE ANY ALREADY-INSTALLED FORMULAE.
brew upgrade

# SAVE HOMEBREW'S INSTALLED LOCATION.
BREW_PREFIX=$(brew --prefix)


##################################################
# INSTALL `rbenv`                                #
##################################################
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/dotfiles/.extra || echo "$LINE" >> ~/dotfiles/.extra

# RESTART YOUR SHELL SO THE PATH CHANGES TAKE EFFECT.
exec "$SHELL"

# VERIFY THAT THE `rbenv` IS PROPERLY SET UP USING THIS `rbenv-doctor` SCRIPT:
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# INSTALL RUBY VERSION
read -p "Which version(s) of Ruby would you like to install? (seperate each by a space) " rubyVersionInput
for i in ${rubyVersionInput[@]}
do
   rbenv install $i
done

read -p "Update the global Ruby version? (y/n) " rubyVersionGlobalBoolean
if [[ $rubyVersionGlobalBoolean =~ ^[Yy]$ ]]; then
  read -p "Which version? " rubyVersionGlobal
  rbenv global $rubyVersionGlobal

   echo "Setting Ruby version to: $rubyVersionGlobal"
   ruby --version
fi;

#!/usr/bin/env bash

# MAKE SURE WE’RE USING THE LATEST HOMEBREW.
brew update

# UPGRADE ANY ALREADY-INSTALLED FORMULAE.
brew upgrade

# SAVE HOMEBREW'S INSTALLED LOCATION.
BREW_PREFIX=$(brew --prefix)


##################################################
# INSTALL `pyenv`                                #
##################################################
brew install pyenv
LINE='eval "$(pyenv init -)"'
grep -q "$LINE" ~/dotfiles/.extra || echo "$LINE" >> ~/dotfiles/.extra

# RESTART YOUR SHELL SO THE PATH CHANGES TAKE EFFECT.
exec "$SHELL";

# INSTALL PYTHON VERSION(S).
read -p "Which version(s) of Python would you like to install? (seperate each by a space) " pythonVersionInput
for i in ${pythonVersionInput[@]}
do
   pyenv install $i
done

read -p "Update the global Python version? (y/n) " pythonVersionGlobalBoolean
if [[ $pythonVersionGlobalBoolean =~ ^[Yy]$ ]]; then
  read -p "Which version? " pythonVersionGlobal
  pyenv global $pythonVersionGlobal

   echo "Setting Python version to: $pythonVersionGlobal"
   python --version
fi;

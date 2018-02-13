#!/usr/bin/env bash

# MAKE SURE WE’RE USING THE LATEST HOMEBREW.
brew update

# UPGRADE ANY ALREADY-INSTALLED FORMULAE.
brew upgrade

##################################################
# INSTALL ESSENTIALS                             #
##################################################
# INSTALL GNU CORE UTILITIES (THOSE THAT COME WITH MACOS ARE OUTDATED).
# DON’T FORGET TO ADD `$(brew --prefix coreutils)/libexec/gnubin` TO `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# INSTALL SOME OTHER USEFUL UTILITIES LIKE `sponge`.
brew install moreutils

# INSTALL GNU `find`, `locate`, `updatedb`, AND `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, OVERWRITING THE BUILT-IN `sed`.
brew install gnu-sed --with-default-names

# INSTALL BASH 4.
# NOTE: DON’T FORGET TO ADD `/usr/local/bin/bash` TO `/etc/shells` BEFORE
# RUNNING `chsh`.
brew install bash
brew install bash-completion2

# SWITCH TO USING BREW-INSTALLED BASH AS DEFAULT SHELL
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# INSTALL `wget` WITH IRI SUPPORT.
brew install wget --with-iri

# INSTALL GnuPG TO ENABLE PGP-SIGNING COMMITS.
brew install gnupg

# INSTALL MORE RECENT VERSIONS OF SOME MACOS TOOLS.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
#brew install homebrew/php/php56 --with-gmp

# INSTALL OTHER USEFULL BINARIES.
brew install git
brew install git-flow
brew install git-lfs
brew install rename
brew install tree


##################################################
# INSTALL PYTHON                                 #
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


##################################################
# INSTALL RUBY                                   #
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


##################################################
# INSTALL CASK                                   #
##################################################
brew tap caskroom/cask

# AFTER YOU INSTALL HOMEBREW-CASK, RUN THE FOLLOWING COMMAND:
brew tap caskroom/versions

# CORE CASKS
#brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" xquartz

# DEVELOPMENT CASKS
brew cask install --appdir="/Applications" insomnia
brew cask install --appdir="/Applications" iterm2
#brew cask install --appdir="/Applications" macdown
#brew cask install --appdir="/Applications" parallels-desktop
brew cask install --appdir="/Applications" sequel-pro
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" sublime-text3
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" vagrant-manager
brew cask install --appdir="/Applications" virtualbox

# BROWSER CASKS
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" firefox-developer-edition
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" google-chrome-canary
brew cask install --appdir="/Applications" opera
brew cask install --appdir="/Applications" opera-neon

# MISC. CASKS
#brew cask install --appdir="/Applications" 1password
brew cask install --appdir="/Applications" alfred
#brew cask install --appdir="/Applications" caffeine     # Keep Mac Awake
#brew cask install --appdir="/Applications" cloudapp
brew cask install --appdir="/Applications" dash
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
#brew cask install --appdir="/Applications" gimp         # Image Editor
#brew cask install --appdir="/Applications" inkscape     # Vector Graphics Editor
#brew cask install --appdir="/Applications" licecap      # Screen Capture
#brew cask install --appdir="/Applications" mou          # Markdown Editor
#brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" spotify
#brew cask install --appdir="/Applications" screenflow   # Video Editing
brew cask install --appdir="/Applications" vlc
#brew cask install --appdir="/Applications" webtorrent   # Streaming Torrent Client

# REMOVE COMMENT TO INSTALL LATEX DISTRIBUTION MacTex
#brew cask install --appdir="/Applications" mactex


##################################################
# INSTALL DOCKER                                 #
##################################################
# INSTALL DOCKER, WHICH REQUIRES VIRTUALBOX
brew cask install docker


##################################################
# INSTALL HEROKU                                 #
##################################################
brew install heroku/brew/heroku
heroku update


##################################################
# INSTALL PLUGINS                                #
##################################################
# DEVELOPER FRIENDLY QUICK LOOK PLUGINS.
# SEE https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# REMOVE OUTDATED VERSIONS FROM THE CELLAR.
brew cleanup

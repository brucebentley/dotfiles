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
#brew cask install java                         #
brew cask install xquartz                       #

# DEVELOPMENT CASKS
brew cask install insomnia                      #
brew cask install iterm2                        #
#brew cask install macdown                      #
#brew cask install parallels-desktop            #
brew cask install sequel-pro                    #
brew cask install sourcetree                    #
brew cask install sublime-text3                 #
brew cask install vagrant                       #
brew cask install vagrant-manager               #
brew cask install virtualbox                    #

# BROWSER CASKS
brew cask install firefox                       #
brew cask install firefox-developer             #
brew cask install google-chrome                 #
brew cask install google-chrome-canary          #
brew cask install opera                         #
brew cask install opera-neon                    #

# MISC. CASKS
#brew cask install 1password                    #
brew cask install alfred                        #
brew cask install bitbar                        # Put Anything In Your macOS Menu Bar
#brew cask install caffeine                     # Keep Mac Awake
#brew cask install cloudapp                     #
brew cask install dash                          #
brew cask install dropbox                       #
brew cask install evernote                      #
#brew cask install gimp                         # Image Editor
#brew cask install inkscape                     # Vector Graphics Editor
#brew cask install licecap                      # Screen Capture
#brew cask install mou                          # Markdown Editor
#brew cask install skype                        #
brew cask install slack                         #
brew cask install spotify                       #
#brew cask install screenflow                   # Video Editing
brew cask install synergy                       # Share keyboard/mouse between computers
brew cask install vlc                           #
#brew cask install webtorrent                   # Streaming Torrent Client

# REMOVE COMMENT TO INSTALL LATEX DISTRIBUTION MacTex
#brew cask install mactex                       #


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

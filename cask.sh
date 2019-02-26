#!/usr/bin/env bash

# MAKE SURE WE’RE USING THE LATEST HOMEBREW.
brew update

# UPGRADE ANY ALREADY-INSTALLED FORMULAE.
brew upgrade

# SAVE HOMEBREW'S INSTALLED LOCATION.
BREW_PREFIX=$(brew --prefix)


##################################################
# INSTALL CASKS                                  #
##################################################
brew tap homebrew/cask-versions

# INSTALL CORE CASKS.
#brew cask install java
#brew cask install xquartz

# INSTALL BROWSER CASKS.
brew cask install firefox
brew cask install firefox-developer-edition
brew cask install google-chrome-canary
#brew cask install opera
#brew cask install opera-neon

# INSTALL CODE EDITORS.
brew cask install sublime-text3
brew cask install visual-studio-code-insiders

# INSTALL DEVELOPMENT CASKS.
#brew cask install gpg-suite
#brew cask install google-cloud-sdk
#brew cask install insomnia
brew cask install iterm2
#brew cask install macdown
brew cask install postman
brew cask install sequel-pro
brew cask install sourcetree
#brew cask install vagrant
#brew cask install vagrant-manager
#brew cask install virtualbox

# INSTALL DOCKER.
brew cask install docker
brew cask install kitematic

# INSTALL MISCELLANOUS CASKS.
#brew cask install 1password
brew cask install alfred
brew cask install bartender
brew cask install bitbar                        # Put Anything In Your macOS Menu Bar
#brew cask install caffeine                     # Keep Mac Awake
#brew cask install cloudapp
#brew cask install dash
brew cask install dropbox
brew cask install evernote
#brew cask install gimp                         # Image Editor
#brew cask install inkscape                     # Vector Graphics Editor
brew cask install istat-menus
#brew cask install licecap                      # Screen Capture
#brew cask install mou                          # Markdown Editor
brew cask install plex-media-player
brew cask install sketchpacks                   # Sketch Plugin Manager
brew cask install slack
brew cask install spotify
#brew cask install screenflow                   # Video Editing
#brew cask install synergy                      # Share keyboard/mouse between computers
brew cask install vlc
#brew cask install webtorrent                   # Streaming Torrent Client


##################################################
# INSTALL FONTS                                  #
##################################################
brew tap homebrew/cask-fonts

brew cask install font-anonymouspro-nerd-font
brew cask install font-droidsansmono-nerd-font
brew cask install font-firacode-nerd-font
brew cask install font-hack-nerd-font
brew cask install font-mplus-nerd-font
brew cask install font-noto-sans
brew cask install font-open-sans
brew cask install font-raleway
brew cask install font-roboto
brew cask install font-roboto-condensed
brew cask install font-roboto-slab
brew cask install font-robotomono-nerd-font
brew cask install font-sourcecodepro-nerd-font
brew cask install font-ubuntumono-nerd-font


##################################################
# CLEANUP                                        #
##################################################

# REMOVE OUTDATED VERSIONS FROM THE CELLAR.
brew cleanup

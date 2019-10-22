#!/usr/bin/env bash

# MAKE SURE WE’RE USING THE LATEST HOMEBREW.
brew update

# UPGRADE ANY ALREADY-INSTALLED FORMULAE.
brew upgrade

# SAVE HOMEBREW'S INSTALLED LOCATION.
BREW_PREFIX=$(brew --prefix)


##################################################
# INSTALL ESSENTIALS                             #
##################################################
# INSTALL GNU CORE UTILITIES (THOSE THAT COME WITH MACOS ARE OUTDATED).
# DON’T FORGET TO ADD THE FOLLOWING TO YOUR $PATH.
#     $(brew --prefix coreutils)/libexec/gnubin
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# INSTALL SOME OTHER USEFUL UTILITIES LIKE `sponge`.
brew install moreutils

# INSTALL GNU `find`, `locate`, `updatedb`, AND `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, OVERWRITING THE BUILT-IN `sed`.
brew install gnu-sed

# INSTALL A MODERN VERSION OF BASH.
# NOTE: DON’T FORGET TO ADD `/usr/local/bin/bash` TO `/etc/shells` BEFORE
# RUNNING `chsh`.
brew install bash
brew install bash-completion2

# SWITCH TO USING BREW-INSTALLED BASH AS DEFAULT SHELL
if ! grep -F -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
    echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
    chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# INSTALL `wget` WITH IRI SUPPORT.
brew install wget

# INSTALL GnuPG TO ENABLE PGP-SIGNING COMMITS.
brew install gnupg

# INSTALL MORE RECENT VERSIONS OF SOME MACOS TOOLS.
brew install vim
brew link vim
brew install grep
brew install openssh
brew install screen
#brew install php
brew install gmp


##################################################
# INSTALL FONT TOOLS                             #
##################################################
#brew tap bramstein/webfonttools
#brew install sfnt2woff
#brew install sfnt2woff-zopfli
#brew install woff2

# LIBRARY TO RENDER FONTS.
brew install freetype


##################################################
# INSTALL SOME CTF TOOLS                         #
#     SEE https://github.com/ctfs/write-ups      #
##################################################
#brew install aircrack-ng
#brew install bfg
#brew install binutils
#brew install binwalk
#brew install cifer
#brew install dex2jar
#brew install dns2tcp
#brew install fcrackzip
#brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
#brew install netpbm
#brew install nmap
#brew install pngcheck
#brew install socat
#brew install sqlmap
#brew install tcpflow
#brew install tcpreplay
#brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install xpdf
brew install xz


##################################################
# INSTALL OTHER USEFUL BINARIES                  #
##################################################
brew install ack
# PERL LIBRARY FOR READING, WRITING & EDITING EXIF METADATA.
brew install exiftool
#brew install exiv2
brew install git
brew install git-lfs
# BASH-TOOL TO STORE THE PRIVATE DATA INSIDE A GIT REPO.
brew install git-secret
brew install gs
# TOOLS AND LIBRARIES TO MANIPULATE IMAGES IN MANY FORMATS.
brew install imagemagick --with-webp
brew install lua
#brew install lynx
#brew install p7zip
#brew install pigz
brew install pv
brew install rename
#brew install rlwrap
brew install ssh-copy-id
brew install tree
#brew install vbindiff
brew install yarn --ignore-dependencies
#brew install zopfli


##################################################
# DEVELOPMENT UTILITIES                          #
##################################################
# ENABLE SSL CERTIFICATE SUPPORT ON YOUR LOCAL DEV ENVIRONMENT.
brew install mkcert
# COMMAND-LINE COLLECTION RUNNER FOR POSTMAN.
brew install newman
brew install nss # IF YOU USE FIREFOX
# AUTOFORMAT SHELL SCRIPT SOURCE CODE.
brew install shfmt


##################################################
# CLEANUP                                        #
##################################################

# REMOVE OUTDATED VERSIONS FROM THE CELLAR.
brew cleanup


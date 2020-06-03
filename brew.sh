#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Install Command-Line Tools Using Homebrew
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make Sure We’re Using The Latest Homebrew
brew update

# Upgrade Any Already-Installed Formulae
brew upgrade

# Save Homebrew’s Installed Location
BREW_PREFIX=$(brew --prefix)


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Core Utilities
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#

# Install GNU Core Utilities
#   Don't Forget To Add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`
brew install coreutils              # GNU File, Shell, & Text utilities
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

core_tools_list=(
    moreutils                       # Collection of tools that nobody wrote when UNIX was young
    findutils                       # Collection of GNU `find`, `xargs`, & `locate`
    gnu-sed --with-default-names    # GNU implementation of the famous stream editor
    bash                            # Bourne-Again SHell, a UNIX command interpreter
    bash-completion2                # Programmable completion for Bash 4.1+
    zsh                             # UNIX shell ( command interpreter )
    zsh-completions                 # Additional completion definitions for zsh
    gnupg                           # GNU Pretty Good Privacy ( PGP ) package
)
for core_tool in "${core_tools_list[@]}"
do
    brew install "${core_tool}"
done

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  #chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Switch to using brew-installed zsh as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/zsh";
fi;


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install More Newer Versions Of macOS Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macos_tools_list=(
    vim                         # Vi 'workalike' with many additional features
    wget                        # Internet file retriever
    curl                        # Get a file from an HTTP, HTTPS or FTP server
    grep                        # GNU `grep`, `egrep` & `fgrep`
    make                        # Utility for directing compilation
    openssh                     # OpenBSD freely-licensed SSH connectivity tools
    openssl                     # Cryptography & SSL/TLS Toolkit
    screen                      # Terminal multiplexer with VT100/ANSI terminal emulation
    #php                        # General-purpose scripting language
    gmp                         # GNU multiple precision arithmetic library
)
for macos_tool in "${macos_tools_list[@]}"
do
    brew install "${macos_tool}"
done

#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Git & Some Useful Addons
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
git_tools_list=(
    git                         # Distributed revision control system
    git-lfs                     # Git extension for versioning large files
    git-extras                  # Small git utilities
    git-flow                    # Extensions to follow Vincent Driessen's branching model
    git-secret                  # Bash-tool to store the private data inside a git repo
)
for git_tool in "${git_tools_list[@]}"
do
    brew install "${git_tool}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Font Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#brew tap bramstein/webfonttools
font_tools_list=(
    #sfnt2woff                  # Convert existing TrueType/OpenType fonts to WOFF format
    #sfnt2woff-zopfli           # WOFF utilities with Zopfli compression
    #sfntly                     # Library for Using, Editing, and Creating SFNT-based Fonts
    #woff2                      # Compress fonts with Brotli into WOFF2 format
    #freetype                   # Software library to render fonts
)
for font_tool in "${font_tools_list[@]}"
do
    brew install "${font_tool}"
done

#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Some CTF Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# See: https://github.com/ctfs/write-ups.
#
ctf_tools_list=(
    #aircrack-ng                # Next-generation aircrack with lots of new features
    #bfg                        # Remove large files or passwords from Git history like git-filter-branch
    #binutils                   # GNU binary tools for native development
    #binwalk                    # Searches a binary image for embedded files and executable code
    #cifer                      # Work on automating classical cipher cracking in C
    #dex2jar                    # Tools to work with Android .dex and Java .class files
    #dns2tcp                    # TCP over DNS tunnel
    #fcrackzip                  # Zip password cracker
    #foremost                   # Console program to recover files based on their headers and footers
    #hashpump                   # Tool to exploit hash length extension attack
    #hydra                      # Network logon cracker which supports many services
    #john                       # Featureful UNIX password cracker
    #knock                      # Port-knock server
    #netpbm                     # Image manipulation
    #nmap                       # Port scanning utility for large networks
    #pngcheck                   # Print info and check PNG, JNG, and MNG files
    #socat                      # SOcket CAT: netcat on steroids
    #sqlmap                     # Penetration testing for SQL injection and database servers
    #tcpflow                    # TCP flow recorder
    #tcpreplay                  # Replay saved tcpdump files at arbitrary speeds
    #tcptrace                   # Analyze tcpdump output
    #ucspi-tcp                  # Tools for building TCP client-server applications
    #xpdf                       # PDF Viewer
    xz                          # General-purpose data compression with high compression ratio
)
for ctf_tool in "${ctf_tools_list[@]}"
do
    brew install "${ctf_tool}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Other Useful Binaries
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
useful_tools_list=(
    ack                         # Search tool like `grep`, but optimized for programmers
    cmake                       # Cross-platform `make`
    dnsmasq                     # Lightweight DNS forwarder & DHCP server
    exiftool                    # Perl lib for reading & writing EXIF metadata
    #exiv2                      # EXIF and IPTC metadata manipulation library & tools
    gettext                     # GNU internationalization ( i18n ) & localization ( l10n ) library
    go                          # Open source programming language to build simple/reliable/efficient software
    gs                          # Interpreter for PostScript and PDF
    #heroku                     #
    htop                        # Improved top ( interactive process viewer )
    imagemagick --with-webp     # Tools & libraries to manipulate images in many formats
    jq                          # Lightweight and flexible command-line JSON processor
    lua                         # Powerful, lightweight programming language
    #lynx                       # Text-based web browser
    mas                         # Mac App Store command-line interface
    neovim                      # Ambitious Vim-fork focused on extensibility and agility
    newman                      # Command-line collection runner for Postman
    ngrep                       # Network Grep
    nss                         # Libraries for security-enabled client and server applications
    p7zip                       # 7-Zip ( high compression file archiver ) implementation
    pigz                        # Parallel gzip
    pinentry                    # Passphrase entry dialog utilizing the Assuan protocol
    pinentry-mac                # Pinentry for GPG on Mac
    pkg-con                     #
    #pv                         # Monitor data's progress through a pipe
    readline                    # Library for command-line editing
    rename                      # Perl-powered file rename script with many helpful built-ins
    rlwrap                      # Readline wrapper: adds readline support to tools that lack it
    shellcheck                  # Static analysis and lint tool, for (ba)sh scripts
    shfmt                       # Autoformat shell script source code
    ssh-copy-id                 # Add a public key to a remote machine's authorized_keys file
    thefuck                     # Programatically correct mistyped console commands
    tmux                        # Terminal multiplexer
    tree                        # Display directories as trees ( with optional color/HTML output )
    #vbindiff                   # Visual Binary Diff
    #zopfli                     # New `zlib` ( `gzip`, `deflate` ) compatible compressor
)
for useful_tool in "${useful_tools_list[@]}"
do
    brew install "${useful_tool}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Image & Video Editing Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
media_tools_list=(
    ffmpeg                      # Play, Record, Convert, & Stream Audio & Video
    webp                        # Image Format Providing Lossless & Lossy Compression For Web Images
    youtube-dl                  # Download Youtube Videos From The Command-Line
)
for media_tool in "${media_tools_list[@]}"
do
    brew install "${media_tool}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Development Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
dev_tools_list=(
    #helm                               # The Kubernetes Package Manager
    imagemagick@6 --build-from-source   # Tools & Libraries To Manipulate Images In Many Formats
    sphinx                              # Full-Text Search Engine
    redis                               # Persistent Key-Value Database, With Built-In Net Interface
    mysql@5.7                           # Open Source Relational Database Management System
    overmind                            # Process Manager For Procfile-Based Applications And tmux
    v8@3.15                             # Google's JavaScript Engine
)
for dev_tool in "${dev_tools_list[@]}"
do
    brew install "${dev_tool}"
done

# Unlink the latest version ( v 8.0.x ) of MySQL that was just installed by Sphinx:
brew unlink mysql

# Start `redis` now & set `redis` to launch on system restart:
brew services start redis

brew update
brew install mysql@5.7

# You'll want to make sure that the version of MySQL doesn't get automatically updated when
# running `brew upgrade` in the future, so let's use `brew pin` to lock it in:
brew link --force mysql@5.7
brew pin mysql@5.7

# After a successful installation, you can start the server & ensure it auto-starts in the future with:
brew services start mysql@5.7

# Run the secure installation setup for MySQL.
#   DO NOT set a password for the `root` user during this setup!
/usr/local/bin/mysql_secure_installation


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Cleanup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Remove Outdated Versions From The Cellar
brew cleanup

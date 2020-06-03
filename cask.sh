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
# Tap Additional Homebrew Repositories
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
brew_tap_list=(
    homebrew/cask-versions
    homebrew/cask-fonts
)
for tap in "${brew_tap_list[@]}"
do
    brew tap "${tap}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Core Casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
core_cask_list=(
    #java        # OpenJDK Binaries
    #xquartz     # Allow Cross-Platform Applications Using X11 To Run On macOS
)
for core_cask in "${core_cask_list[@]}"
do
    brew cask install "${core_cask}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Browser Casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
browser_cask_list=(
    brave-browser
    brave-browser-dev
    firefox
    firefox-developer-edition
    google-chrome
    google-chrome-canary
    microsoft-edge
    #opera
    #opera-developer
    #opera-neon
    safari-technology-preview
    tor-browser
    #vivaldi
)
for browser in "${browser_cask_list[@]}"
do
    brew cask install "${browser}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Code Editors
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
code_editor_cask_list=(
    sublime-text
    visual-studio-code-insiders
)
for editor in "${code_editor_cask_list[@]}"
do
    brew cask install "${editor}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Development Casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
development_cask_list=(
    docker              # Containerization Platform
    #google-cloud-sdk   # CLI Tools For Google Cloud Engine
    gpg-suite           # GPG-Encryption For Emails & Files
    hyper               # Terminal Emulator
    #insomnia           # Desktop API Client For REST & GraphQL
    #insomnia-designer  # Collaborative API Design Tool For Designing & Managing OpenAPI Specs
    iterm2              # Terminal Emulator
    kitematic           # Run Containers Through A Simple, Yet Powerful GUI
    #macdown            # Open Source Markdown Editor For macOS
    postman             # Collaboration Platform For API Development
    sequel-pro          # Desktop GUI For Interacting With MySQL Databases
    sourcetree          # Desktop GUI For Git
    #vagrant            # Tool For Building & Managing Virtual Machine Environments
    #vagrant-manager    # Manage Your Vagrant Machines In One Place
    #virtualbox         # Virtualization Product For Running Virtual Machines
)
for dev_cask in "${development_cask_list[@]}"
do
    brew cask install "${dev_cask}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Miscellanous Casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
misc_cask_list=(
    #1password         # Password, Software License, Identity & Other Secure Data Manager
    alfred             # macOS Automation & Shortcut Utility
    authy              # 2FA Client & Backup
    bartender          # Manage The macOS Menu Bar
    #bitbar            # Put Anything In Your macOS Menu Bar
    box-drive          # Box.com Cloud Storage & Collaboration Platform
    #caffeine          # Prevent Your Mac From Automatically Going To Sleep
    calibre            # E-Book Management
    #cloudapp          # Record Video, Webcam, Gifs, Capture Your Screen And Share It Instantly To The Cloud
    #dash              # Docuementation Manager
    discord            # Communicate Over Voice, Video, And Text
    dropbox            # Cloud Storage & Collaboration Platform
    duet               # Turn Your iOS Or Android Device Into A High Performance Second Display For Your Mac & PC
    #evernote          # Save, Sync & Share Everything
    #flickr-uploadr    # Flickr Desktop Uploader
    #gimp              # Free & Open Source Image Editor
    hammerspoon        # Automation Utility For macOS
    #handbrake         # Open-Source Video Transcoder
    imageoptim         # Lossless Image Compressor
    #inkscape          # Vector Graphics Editor
    istat-menus        # Display Stats In Your macOS Menu Bar
    #licecap           # Simple Animated Screen Captures
    keybase            # End-To-End Encryption For Things That Matter
    megasync           # Automated Synchronisation Between Your Computer And Your Mega Cloud
    #mou               # Markdown Editor
    nordvpn            # VPN Client For NordVPN
    plex-media-player  # A Client-Server Media Player
    #plex-media-server # Organize & Store Your Media Library For Playback With Plex Media Clients
    prince             # Convert HTML to PDF
    sketch             # Vector Graphics Editor For Macos
    sketchpacks        # Sketch Plugin Manager
    slack              # Communication & Sharing Platform For Individuals, Teams & Organizations
    spotify            # Desktop Player For The Online Digital Music Service
    #screenflow        # Video Editing & Screen Recording
    #synergy           # Share Keyboard/Mouse Between Computers
    transmission       # Cross-Platform BitTorrent Client
    vlc                # Open-Source Portable Cross-Platform Media Player
    #webtorrent        # Streaming Torrent Client
    zeplin             # Share, Organize & Collaborate On UI/UX Designs
)
for misc_cask in "${misc_cask_list[@]}"
do
    brew cask install "${misc_cask}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Fonts
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
font_cask_list=(
    jetbrains-mono
    noto-sans
    open-sans
    raleway
    roboto
    roboto-condensed
    roboto-slab
)
for font in "${font_cask_list[@]}"
do
    brew cask install "font-${font}"
done

# Search & Install All Available Nerd Fonts ( 50+ )
brew cask install $( brew search font | grep nerd | tr '\n' ' ' )


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Cleanup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Remove Outdated Versions From The Cellar
brew cleanup

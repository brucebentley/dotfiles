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


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Tap Additional Homebrew Repositories
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
brew_tap_list=(
    homebrew/cask-drivers               # https://github.com/Homebrew/homebrew-cask-drivers
)
for tap in "${brew_tap_list[@]}"
do
    brew tap "${tap}"
done

#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Audio Drivers
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
speaker_control_drivers_list=(
    bose-soundtouch    # Control Bose SoundTouch systems from your computer.
    bose-updater       # Software updates for Bose products.
    sonos              # Control your Sonos system using the new Sonos S2 app.
)
for speaker_control_driver in "${speaker_control_drivers_list[@]}"
do
    brew install "${speaker_control_driver}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Peripheral Apps & Drivers
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
peripheral_drivers_list=(
    caldigit-docking-utility        #
    caldigit-thunderbolt-charging   #
    #corsair-icue                    # Monitor system performance, tune RGB settings, & control fan speeds on your Corsair devices.
    #elgato-control-center           #
    #elgato-game-capture-hd          #
    #elgato-thunderbolt-dock         #
    #elgato-video-capture            #
    #logitech-control-center         #
    #logitech-firmwareupdatetool     #
    #logitech-gaming-software        #
    #logitech-g-hub                  #
    #logitech-options                #
    #logitech-unifying               #
    #nvidia-cuda-toolkit             # Tools to create high performance GPU-accelerated applications.
    #razer-synapse                   # Monitor system performance, tune RGB settings, & control fan speeds on your Razer devices.
)
for peripheral_driver in "${peripheral_drivers_list[@]}"
do
    brew install "${peripheral_driver}"
done

#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Smart Home Drivers
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
smarthome_drivers_list=(
    netgear-switch-discovery-tool
    philips-hue-sync   # Highlight & Amplify Your In-Game Actions With Your Philip's Hue Smart Lights.
)
for smarthome_driver in "${smarthome_drivers_list[@]}"
do
    brew install "${smarthome_driver}"
done

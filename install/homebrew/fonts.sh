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
    homebrew/cask-versions              # Required to install
    homebrew/cask-fonts                 # Required to install
    homebrew/cask-drivers               # Required to install Homebrew drivers defined in `drivers.sh`
    mongodb/brew                        # Required to install
    brew tap jakehilborn/jakehilborn    # Required to install `displayplacer`
)
for tap in "${brew_tap_list[@]}"
do
    brew tap "${tap}"
done

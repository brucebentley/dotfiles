#!/bin/bash

#
# Install the ChefDK on macOS
#
# @USAGE
#     ./chefdk-macos-install.sh
#
#     Arguments:
#           VERSION         Version of the ChefDK to install
#           URL_PREFIX      URL of the ChefDK package download
#           PKG_NAME        Name of the ChefDK package to install
#           SHA_256         Hash for the ChefDK package version
#
# @PROCESS OVERVIEW
#     1. Open the Terminal or iTerm application on your Mac.
#     2. Navigate to the directory where you saved the `chefdk-macos-install.sh` script. For example:
#            $ cd ~/dotfiles/scripts/
#     3. Make sure that the `chefdk-macos-install.sh` file is executable:
#            $ chmod u+x chefdk-macos-install.sh
#     4. Now, execute & run the following script to convert your movie:
#            $ ./chefdk-macos-install.sh
#     5. The script downloads the specified `ChefDK` package to the Current User's `~/Downloads` directory.
#            $ cd ~/Downloads
#            $ curl -O "${URL_PREFIX}/${PKG_NAME}"
#     6. Once downloaded, it will mount the downloaded `.dmg` file for the ChefDK installation.
#            $ hdiutil attach ${PKG_NAME}
#     7. Now mounted, it navigates to the mounted volume directory.
#            $ cd "/Volumes/${VOLUME_NAME/"
#     8. It looks for the ChefDK `.pkg` within this directory, installs as the root user, to the `/` (root) directory.
#            $ sudo installer -pkg ${PKG_NAME} -target "/"
#     9. The ChefDK installs.
#    10. Once complete, the script will navigate out of the mounted volume directory, to the `~/Downloads` directory.
#            $ cd ~/Downloads
#    11. Finally, the script will eject (unmount) the ChefDK disk image.
#

VERSION='2.3.4'                               # Our Current ChefDK Version
URL_PREFIX="https://packages.chef.io/files/stable/chefdk/${VERSION}/mac_os_x/10.12/"
SHA_256="8e995e574ec41226ec9eeca4705835b4b4d912296f1edb2d6320f9d845dd948d"
PKG_NAME="chefdk-${VERSION}-1.dmg"            # Package Name OF The Downloaded `.dmg` File
VOLUME_NAME="Chef Development Kit"            # Mounted Volume Name Of The `.dmg` File On macOS

##################################################
# SCRIPT EXECUTION
##################################################
bold=$(tput bold);                            # Bold Text
reset=$(tput sgr0);                           # Reset Text

function installChefDK() {
    echo -e "${bold}Getting ready to install the ChefDK v${VERSION} ...${reset}";
    echo "";

    # Navigate To Directory Where We'll Save The ChefDK Package.
    cd ~/Downloads

    # Download The Specified ChefDK Package.
    curl -O "${URL_PREFIX}/${PKG_NAME}"
    echo "";
    echo -e "${bold}Successfully downloaded the ${PKG_NAME} to the '~/Downloads' directory ...${reset}";
    echo "";

    # Mount The Downloaded ChefDK Package To `/Volumes/Chef Development Kit".
    hdiutil attach ${PKG_NAME}
    echo "";
    echo -e "${bold}Successfully mounted ${PKG_NAME} Volume to '/Volumes/${VOLUME_NAME}' ...${reset}";
    echo "";

    # Navigate To The Mounted Volume Directory.
    cd "/Volumes/${VOLUME_NAME}/"

    # Install To The `/` (root) Directory, As The `sudo` (root) User.
    sudo installer -pkg "chefdk-${VERSION}-1.pkg" -target "/"
    echo "";
    echo -e "${bold}Successfully installed chefdk-${VERSION}-1.pkg to the '/' (root) directory ...${reset}";
    echo "";

    # Navigate Out Of The Mounted Volume Directory, Back To The Current User's `~/Downloads` Directory.
    cd ~/Downloads

    # Eject (unmount) The ChefDK Disk Image.
    hdiutil detach "/Volumes/${VOLUME_NAME}/"
    echo "";
    echo -e "${bold}Successfully ejected (unmounted) ${PKG_NAME} Disk Image ...${reset}";
    echo "";
}

function installRbenv() {
    # Check if Homebrew is installed
    echo -e "${bold}Checking for rbenv installation ...${reset}";
    echo "";

    which -s rbenv
    if [[ $? != 0 ]]; then
        # Install rbenv
        # https://github.com/rbenv/rbenv#installation
        echo -e "${bold}Installing rbenv ...${reset}";
        echo "";
        brew update;
        brew install rbenv;
        rbenv init;
    else
        echo -e "${bold}Installing ChefDK plugin for rbenv ...${reset}";
        echo "";
        git clone https://github.com/docwhat/rbenv-chefdk.git $(rbenv root)/TEST/plugins;
        mkdir -p $(rbenv root)/TEST/versions/chefdk;

        rbenv local chefdk;
        rbenv rehash;
        RUBY_PATH=`rbenv which ruby`;
        RUBY_VERSION=`ruby --version`;

        echo -e "${bold}Ruby Executable Path: ${reset}\n    ${RUBY_PATH}";
        echo -e "${bold}Ruby Version: ${reset}\n    ${RUBY_VERSION}";
    fi

    echo "";
    echo -e "${bold}The next time you log-in, you can run the following, and test for Chef
    before and after switching to chefdk:${reset}"
    echo "";
    echo -e "    $ rbenv which ruby
    /home/vagrant/.rbenv/versions/2.3.6/bin/ruby
    $ gem list | grep 'chef\s'

    $ rbenv global chefdk
    $ rbenv which ruby
    /opt/chefdk/embedded/bin/ruby
    $ gem list | grep 'chef\s'
    chef (14.1.12, 13.4.19, 12.19.36)";

    echo "";
    echo -e "${bold}If you need to use ChefDK in your chef repository for all cookbooks, or
    maybe just a single cookbook, you can use '.ruby-version' mechanism to lock the version
    of ruby in that directory.${reset}"
    echo "";
    echo -e "    $ cd /path/to/your/cookbook
    $ echo chefdk > .ruby-version";
    echo "";
}

installChefDK && installRbenv
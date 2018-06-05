#!/usr/bin/env bash

#
# INSTALL MAC APP STORE APPS
#

# Check if Homebrew is installed
which -s brew
if [[ $? != 0 ]]; then
    # Install Homebrew
    # https://docs.brew.sh/Installation
    echo "Installing Homebrew ..."
    echo
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Updating Homebrew ..."
    echo
    brew update --quiet
fi

# Check to see if the `mas-cli` package is already installed.
which -s mas || brew install mas


loginToAppStore () {

    # Test if signed in. If not, launch MAS and sign in.
    until (mas account > /dev/null); # If signed in, drop to outer "done"
    do

        # If here, not logged in
        echo -e "You are not signed into the Mac App Store."
        echo -e "Launching the Mac App Store application ..."
        echo -e "\nPlease sign in using the Mac App Store application."
        open -a "/Applications/App Store.app"

        # Until loop waits patiently until scriptrunner signs into Mac App Store
        until (mas account > /dev/null);
        do
            sleep 3
        echo -e "… waiting for sign in …."
        done
    done
}

# Open the Mac App Store and wait for user to sign in.
loginToAppStore

# Verify that the user is successfully signed in.
echo -e "You are now signed into the Mac App Store."
SIGNED_IN_USER=$(mas account)
echo -e "APPLE ID: $SIGNED_IN_USER"

# Install apps from the Mac App Store
mas install 405843582   # Alfred                     - Keyboard Productivity & Shortcuts
mas install 937984704   # Amphetamine                - Keep Your Mac Awake
mas install 603117688   # CCMenu                     - Displays Project Build Status In macOS Menu Bar
mas install 420939835   # Clipboard History          - Configurable clipboard History.
mas install 549083868   # Display Menu               - Change Display Settings From The macOS Menu Bar
mas install 715464874   # Disk Map                   - Visualize Hard Drive Usage & Free Space
#mas install 413857545   # Divvy                     - Window Management & Organization
mas install 412448059   # ForkLift                   - FTP/SFTP/WebDAV/Amazon S3 Client
mas install 409183694   # Keynote                    - Presentations
mas install 441258766   # Magnet                     - Workspace Organization
mas install 715768417   # Microsoft Remote Desktop   - Remote Desktop Client
mas install 409203825   # Numbers                    - Spreadsheets
mas install 823766827   # OneDrive                   - To-Do Lists, Notes, Drawings, & More
mas install 409201541   # Pages                      - Document Processor
mas install 425955336   # Skitch                     - Screenshots, Annotations & Markup
mas install 803453959   # Slack                      - Team Communication
mas install 1176895641  # Spark                      - Email Client
mas install 639968404   # Parcel                     - Delivery Tracking
#mas install 410628904   # Wunderlist                - To-Do List & Tasks

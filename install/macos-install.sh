#!/usr/bin/env bash

#
# INSTALLS APPLICATIONS FROM THE MAC APPSTORE.
#

# CHECK IF HOMEBREW IS INSTALLED.
which -s brew
if [[ $? != 0 ]]; then
    # INSTALL HOMEBREW IF IT'S NOT ALREADY INSTALLED.
    # SEE https://docs.brew.sh/Installation
    echo "Installing Homebrew ..."
    echo
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Updating Homebrew ..."
    echo
    # MAKE SURE WE’RE USING THE LATEST HOMEBREW.
    brew update --quiet
fi

# CHECK TO SEE IF THE `mas-cli` PACKAGE IS ALREADY INSTALLED.
which -s mas || brew install mas


loginToAppStore () {

    # TEST IF SIGNED IN. IF NOT, LAUNCH mas AND SIGN IN.
    until (mas account > /dev/null); # IF SIGNED IN, DROP TO OUTER "DONE"
    do

        # IF HERE, NOT LOGGED IN.
        echo -e "You are not signed into the Mac App Store."
        echo -e "Launching the Mac App Store application ..."
        echo -e "\nPlease sign in using the Mac App Store application."
        open -a "/Applications/App Store.app"

        # UNTIL LOOP WAITS PATIENTLY UNTIL SCRIPTRUNNER SIGNS INTO MAC APPSTORE.
        until (mas account > /dev/null);
        do
            sleep 3
        echo -e "… waiting for sign in …."
        done
    done
}

#
# OPEN THE MAC APPSTORE AND WAIT FOR USER TO SIGN IN.
#
loginToAppStore

#
# VERIFY THAT THE USER IS SUCCESSFULLY SIGNED IN.
#
echo -e "You are now signed into the Mac App Store."
SIGNED_IN_USER=$(mas account)
echo -e "APPLE ID: $SIGNED_IN_USER"

#
# INSTALL APPS FROM THE MAC APPSTORE.
#
mas install 1333542190    # 1Password           - Password Manager
mas install 937984704     # Amphetamine         - Powerful "Keep-Awake" Utility
mas install 1287445660    # Agenda              - Date Focused Note Taking
mas install 1091189122    # Bear                - Elegant Writing & Note Taking
mas install 603117688     # CCMenu              - Displays Project Build Status In macOS Menu Bar
mas install 420939835     # Clipboard History   - Clipboard Management Utility
mas install 549083868     # Display Menu        - Change Display Settings From The macOS Menu Bar
mas install 715464874     # Disk Map            - Visualize Hard Drive Usage & Free Space
mas install 413857545     # Divvy               - Window Management & Organization
mas install 406056744     # Evernote            - Notepad, Organizer & Journal
mas install 412448059     # ForkLift            - File Manager and FTP/SFTP/WebDAV/Amazon S3 client
mas install 926036361     # LastPass            - Password Manager
mas install 409183694     # Keynote             - Presentations
mas install 441258766     # Magnet              - Organize Your Workspace
mas install 540348655     # Monosnap            - Screenshot Editor
mas install 1295203466    # Microsoft RDP 10    - Remote Desktop Management
mas install 409203825     # Numbers             - Spreadsheets
mas install 409201541     # Pages               - Document Processor
mas install 639968404     # Parcel              - Delivery Tracking
mas install 568494494     # Pocket              - News & Read It Later
mas install 425955336     # Skitch              - Screenshots, Annotations & Markup
mas install 1006087419    # SnippetsLab         - Code Snippet Organizer & Library
mas install 1176895641    # Spark               - Email App
mas install 1109319285    # SSH Config Editor   - Easily Manage Your SSH Configurations
mas install 425424353     # TheUnarchiver       - Unarchiving Utility
mas install 1436522307    # Transmit 5          - Fast & Easy File Transfers

#
# INSTALL SAFARI EXTENSIONS ROM THE MAC APPSTORE.
#   @URL: https://itunes.apple.com/us/story/id1377753262
#
mas install 957810159     # Raindrop.io         - All-In-One Bookmark Manager

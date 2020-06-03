#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Install Applications From The Mac App Store
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
# Install `mas-cli`
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
which -s mas || brew install mas


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Login To The Mac App Store
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
loginToAppStore () {
    # Test If Signed In. If Not, Launch Mas And Sign In
    until (mas account > /dev/null);  # If Signed In, Drop To Outer "Done"
    do

        # If Here, Not Logged In.
        echo -e "You are not signed into the Mac App Store."
        echo -e "Launching the Mac App Store application ..."
        echo -e "\nPlease sign in using the Mac App Store application."
        open -a "/Applications/App Store.app"

        # Until Loop Waits Patiently Until Scriptrunner Signs Into Mac App Store
        until (mas account > /dev/null);
        do
            sleep 3
        echo -e "… waiting for sign in …."
        done
    done
}
# Open The Mac Appstore And Wait For User To Sign In
loginToAppStore

# Verify That The User Is Successfully Signed In
echo -e "You are now signed into the Mac App Store!"
SIGNED_IN_USER=$(mas account)
echo -e "APPLE ID: $SIGNED_IN_USER"


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install Applications
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macos_apps_list=(
    1333542190      # 1Password 7        - Password Manager
    #1402042596     # AdBlock            - Ad & Popup Blocker ( Safari Extension )
    #1287445660     # Agenda             - Date Focused Note Taking
    937984704       # Amphetamine        - Powerful "Keep-Awake" Utility
    1091189122      # Bear               - Elegant Writing & Note Taking
    #603117688      # CCMenu             - Displays Project Build Status In Macos Menu Bar
    420939835       # ClipboardHistory   - Clipboard Management Utility
    #549083868      # Display Menu       - Change Display Settings From The Macos Menu Bar
    #715464874      # Disk Map           - Visualize Hard Drive Usage & Free Space
    #413857545      # Divvy              - Window Management & Organization
    #406056744      # Evernote           - Notepad, Organizer & Journal
    975937182       # Fantastical        - Calendar & Task Management
    #412448059      # ForkLift           - File Manager And FTP/SFTP/WebDav/Amazon S3 Client
    #1472777122     # Honey              - Smart Shopping Assistant ( Safari Extension )
    #409183694      # Keynote            - Presentations
    926036361       # LastPass           - Password Manager
    #441258766      # Magnet             - Organize Your Workspace
    1295203466      # Microsoft RDP      - Remote Desktop Management
    540348655       # Monosnap           - Screenshot Editor
    #409203825      # Numbers            - Spreadsheets
    #409201541      # Pages              - Document Processor
    #639968404      # Parcel             - Delivery Tracking
    #568494494      # Pocket             - Save Articles, Videos & For Later
    #957810159      # Raindrop.io        - All-In-One Bookmark Manager ( Safari Extension )
    #1477385213     # Save to Pocket     - Capture Stories For Later ( Safari Extension )
    #425955336      # Skitch             - Screenshots, Annotations & Markup
    #1006087419     # SnippetsLab        - Code Snippet Organizer & Library
    1176895641      # Spark              - The Best Personal Email Client
    #1109319285     # SSH Config Editor  - Easily Manage Your SSH Configurations
    425424353       # The Unarchiver     - Unarchiving Utility
    #1436522307     # Transmit 5         - Fast & Easy File Transfers
    #497799835      # Xcode              - Apple'S Integrated Development Environment
)
for macos_app in "${macos_apps_list[@]}"
do
    mas install "${macos_app}"
done

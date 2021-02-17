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
    # - - - - - - - - - - - - - - - - - - - -
    # Installed Apps
    # - - - - - - - - - - - - - - - - - - - -
    1333542190      # [ Free ]    1Password 7        - Password Manager                             ( 7.7 )
    937984704       # [ Free ]    Amphetamine        - Powerful "Keep-Awake" UtilityAmphetamine     ( 5.1.1 )
    1091189122      # [ Free ]    Bear               - Elegant Writing & Note Taking                ( 1.8.2 )
    420939835       # [ $1.99 ]   ClipboardHistory   - Clipboard Management Utility                 ( 1.3.1 )
    975937182       # [ Free ]    Fantastical        - Calendar & Task Management                   ( 3.3.4 )
    412448059       # [ Free ]    ForkLift           - File Manager & FTP/SFTP/WebDav/S3 Client     ( 2.6.6 )
    926036361       # [ Free ]    LastPass           - Password Manager                             ( 4.4.0 )
    441258766       # [ $3.99 ]   Magnet             - Organize Your Workspace                      ( 2.5.0 )
    1295203466      # [ Free ]    Microsoft RDP      - Remote Desktop Management                    ( 4.3.0 )
    540348655       # [ Free ]    Monosnap           - Screenshot Editor                            ( 2.9.15 )
    1176895641      # [ Free ]    Spark              - The Best Personal Email Client               ( 4.2.4 )
    425424353       # [ $5.99 ]   The Unarchiver     - Unarchiving Utility                          ( 1.0.11 )
    497799835       # [ Free ]    Xcode              - Apple'S IDE                                  ( 12.3 )

    # - - - - - - - - - - - - - - - - - - - -
    # Purchased Apps Not Currently Installed
    # - - - - - - - - - - - - - - - - - - - -
    #1402042596     # [ Free ]    AdBlock            - Ad & Popup Blocker ( Safari )                ( 1.27.0 )
    #406056744      # [ Free ]    Evernote           - Notepad, Organizer & Journal                 ( 10.5.7 )
    #1472777122     # [ Free ]    Honey              - Smart Shopping Assistant ( Safari )          ( 12.4.7 )
    #408981434      # [ Free ]    iMovie             - Make Your Own Movie Magic                    ( 10.2.2 )
    #409183694      # [ Free ]    Keynote            - Presentations                                ( 10.3.8 )
    #409203825      # [ Free ]    Numbers            - Spreadsheets                                 ( 10.3.5 )
    #409201541      # [ Free ]    Pages              - Document Processor                           ( 10.3.5 )
    #639968404      # [ Free ]    Parcel             - Delivery Tracking                            ( 6.7.2 )
    #568494494      # [ Free ]    Pocket             - Save Articles, Videos & For Later            ( 1.8.6 )
    #957810159      # [ Free ]    Raindrop.io        - All-In-One Bookmark Manager ( Safari )       ( 2.3.9 )
    #1477385213     # [ Free ]    Save to Pocket     - Capture Stories For Later ( Safari )         ( 1.1 )
    #425955336      # [ Free ]    Skitch             - Screenshots, Annotations & Markup            ( 2.9 )
    #1006087419     # [ $9.99 ]   SnippetsLab        - Code Snippet Organizer & Library             ( 1.9.3 )


    # - - - - - - - - - - - - - - - - - - - -
    # Apps Not Yet Purchased
    # - - - - - - - - - - - - - - - - - - - -
    #1287445660     # [ Free ]    Agenda             - Date Focused Note Taking                     ( 11.2.1 )
    #1339170533     # [ $2.99 ]   BetterSnapTool     - Easy Window Resize & Organize                ( 1.9.5 )
    #603117688      # [ Free ]    CCMenu             - Displays Project Build Status In Menu Bar    ( 15.0 )
    #1339170533     # [ Free ]    CleanMyMac X       - Clean & Protect Your Computer                ( 4.7.3 )
    #549083868      # [ Free ]    Display Menu       - Change Display Settings From The Menu Bar    ( 2.2.3 )
    #715464874      # [ $4.99 ]   Disk Map           - Visualize Hard Drive Usage & Free Space      ( 2.5 )
    #413857545      # [ $13.99 ]  Divvy              - Window Management & Organization             ( 1.5.2 )
    #1224268771     # [ $29.99 ]  Screens 4          - Control Your Computer Remotely               ( 4.8.4 )
    #1109319285     # [ $9.99 ]   SSH Config Editor  - Easily Manage Your SSH Configurations        ( 2.1.1 )
    #1436522307     # [ Free ]    Transmit 5         - Fast & Easy File Transfers                   ( 5 5.7.1 )
)
for macos_app in "${macos_apps_list[@]}"
do
    mas install "${macos_app}"
done


#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# HomeKit Applications
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
macos_homekit_apps_list=(
    # - - - - - - - - - - - - - - - - - - - -
    # Installed Apps
    # - - - - - - - - - - - - - - - - - - - -
    #1476136371     # [ FREE  ]   iWifi - Speed & Signal   - Internet Scanner, Analyzer             ( 1.0.5 )

    # - - - - - - - - - - - - - - - - - - - -
    # Purchased Apps Not Currently Installed
    # - - - - - - - - - - - - - - - - - - - -
    #1330266650      # [ $2.99 ]  HomePass for HomeKit     - Code Storage & Backup                  ( 1.9.1 )


    # - - - - - - - - - - - - - - - - - - - -
    # Apps Not Yet Purchased
    # - - - - - - - - - - - - - - - - - - - -
    #1460522983      # [ FREE  ]  3LED                     - Menu bar client for LIFX               ( 1.1.0 )
    #1445287672      # [ $5.99 ]  Ambi Bridge              - Bridge Ambi Climate Devices To HomeKit ( 1.0.11 )
    #1236886427      # [ FREE  ]  Aura                     - For Philips Hue & LIFX                 ( 3.0.0 )
    #1450752761      # [ $5.99 ]  Harmony Bridge           - Bridge Harmony Hubs To HomeKit         ( 1.0.8 )
    #1275939333      # [ $5.99 ]  Home Control             - HomeKit Alternative For macOS          ( 1.28 )
    #1292995895      # [ $4.99 ]  HomeCam                  - Live Camera Monitor                    ( 2.1.1 )
    #1547121417      # [ $2.99 ]  HomeControl Menu         - Home Control Menu For HomeKit          ( 1.1 )
    #1536545668      # [ FREE  ]  HomeHelper               - Connect Video Surveillance To HomeKit  ( 1.0.2 )
    #1533590432      # [ FREE  ]  Homie—Menu Bar App       - Quick Control For HomeKit              ( 1.0.5 )
    #630956426       # [ FREE  ]  HueParty                 - Dynamic Light Scenes                   ( 7.0.0 )
    #1125894977      # [ FREE  ]  Neon                     - For Philips Hue & LIFX-                ( 3.0.0 )
    #1467513544      # [ $9.99 ]  Roomie Universal Remote  - For Roku, TiVo, Samsung & More         ( 6.5.1 )
    #1540491573      # [ FREE  ]  Scenecuts                - Trigger HomeKit Scenes In The Menu Bar ( 2020.4 )
    #942305623       # [ $2.99 ]  Thessa                   - Widget To Control Nest Thermostats     ( 1.4 )
    #1441858267      # [ $5.99 ]  TPL Bridge               - Bridge TP-Link To HomeKit              ( 1.0.10 )
)
for macos_homekit_app in "${macos_homekit_apps_list[@]}"
do
    mas install "${macos_homekit_app}"
done

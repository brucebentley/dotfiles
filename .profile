#!/usr/bin/env bash

#
# ~/.profile
#

#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
export MANPATH

##
# ANDROID SDK.
##
#export ANDROID_HOME=/usr/local/opt/android-sdk

##
# JAVA JDK 10 CONFIGURATION.
##
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home"


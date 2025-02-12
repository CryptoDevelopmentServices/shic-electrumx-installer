#!/bin/bash
if [ -d ~/.shic-electrumx-installer ]; then
    echo "~/.shic-electrumx-installer already exists."
    echo "Either delete the directory or run ~/.shic-electrumx-installer/install.sh directly."
    exit 1
fi
if which git > /dev/null 2>&1; then
    git clone https://github.com/CryptoDevelopmentServices/shic-electrumx-installer ~/.shic-electrumx-installer
    cd ~/.shic-electrumx-installer/
else
    which wget > /dev/null 2>&1 && which unzip > /dev/null 2>&1 || { echo "Please install git or wget and unzip" && exit 1 ; }
    wget https://github.com/CryptoDevelopmentServices/shic-electrumx-installer/archive/main.zip -O /tmp/shic-electrumx-main.zip
    unzip /tmp/shic-electrumx-main.zip -d ~/.electrumx-installer
    rm /tmp/shic-electrumx-main.zip
    cd ~/.shic-electrumx-installer/shic-electrumx-installer-main/
fi
if [[ $EUID -ne 0 ]]; then
    which sudo > /dev/null 2>&1 || { echo "You need to run this script as root" && exit 1 ; }
    sudo -H ./install.sh "$@"
else
    ./install.sh "$@"
fi

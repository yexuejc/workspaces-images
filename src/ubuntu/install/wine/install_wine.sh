#!/bin/bash
set -ex

# This script currently supports Ubuntu focal only
arch=$(uname -m)

if [[ $arch != "x86_64" ]]; then
    dpkg --add-architecture i386
fi

apt update
wget -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
apt install software-properties-common
apt-add-repository "deb http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
apt install -y --install-recommends winehq-stable winetricks

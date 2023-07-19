#!/bin/bash
set -ex

# This script currently supports Ubuntu focal only
arch=$(uname -m)

if [[ $arch == "x86_64" ]]; then
    dpkg --add-architecture i386
fi

apt update

if [ ! -d "/opt/wine-pkgs" ]; then
    # 在线安装
    wget -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
    apt install software-properties-common
    apt-add-repository "deb http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
    apt install -y --install-recommends winehq-stable winetricks
else
    # 离线安装
    # 离线安装包的来源：在已安装好的PC上执行如下命令进行包的复制
    ### apt update
    ### apt-get clean
    ### apt-get --download-only install winehq-devel
    ### apt-get --download-only dist-upgrade
    ### cp -R /var/cache/apt/archives/ /xxx/wine-pkgs/
    cd /opt/wine-pkgs
    dpkg -i *.deb
    rm -rf /opt/wine-pkgs
fi
#!/bin/bash
set -ex

# This script currently supports Ubuntu focal only
arch=$(uname -m)

dpkg --add-architecture i386

apt update
folder_path=/opt/wine-pkgs

if [ -d "$folder_path" ] && find "$folder_path"  -maxdepth 1 -name "*.deb" -print -quit | grep -q .; then
    # 离线安装
    # 离线安装包的来源：在已安装好的PC上执行如下命令进行包的复制
    ### apt update
    ### apt-get clean
    ### apt-get --download-only install winehq-devel
    ### apt-get --download-only dist-upgrade
    ### cp -R /var/cache/apt/archives/ /xxx/wine-pkgs/
    cd $folder_path
    dpkg -ify *.deb
    rm -rf $folder_path
    
else
    # 在线安装
    wget -qO- https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
    apt install software-properties-common
    apt-add-repository "deb http://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
    apt install -y --install-recommends winehq-stable

fi
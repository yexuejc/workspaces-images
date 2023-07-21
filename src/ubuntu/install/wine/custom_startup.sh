#!/bin/bash
set -ex

folder_path=/opt/wine-pkgs/after
cd $folder_path

if [ -d "$folder_path" ] && find "$folder_path" -name "*.deb" -print -quit | grep -q .; then
    # 安装wineUI
    dpkg -i WineGUI-*.deb
    apt install -fy
    rm -rf WineGUI-*.deb
fi
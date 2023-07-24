#!/bin/bash
set -ex

echo $LANG > /tmp/default_language

apt-get update && apt-get install language-pack-zh-han*
apt install $(check-language-support)

locale-gen zh_CN.UTF-8

cat << EOF >> /etc/default/locale
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh"
LC_NUMERIC="zh_CN"
LC_TIME="zh_CN"
LC_MONETARY="zh_CN"
LC_PAPER="zh_CN"
LC_NAME="zh_CN"
LC_ADDRESS="zh_CN"
LC_TELEPHONE="zh_CN"
LC_MEASUREMENT="zh_CN"
LC_IDENTIFICATION="zh_CN"
LC_ALL="zh_CN.UTF-8"
EOF

update-locale LANG=zh_CN.UTF-8

apt-get install fcitx
cp /usr/share/applications/fcitx.desktop /etc/xdg/autostart/

apt purge ibus

dpkg -i /opt/wine-pkgs/after/sogoupinyin_*.deb
apt install -fy

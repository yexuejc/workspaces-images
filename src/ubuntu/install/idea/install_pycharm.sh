#!/usr/bin/env bash
set -ex

if [ "$(arch)" == "aarch64" ] ; then
    OS_NAME=linuxARM64
else
    OS_NAME=linux
fi
# 安装最新的pycharm
cd /opt

if [ ! -f "pycharm.tar.gz" ]; then
    curl --location --request GET 'https://data.services.jetbrains.com/products/releases?code=PCP&latest=true&type=release' -o pycharm-version.json

    LINK=$(cat pycharm-version.json | grep -o "\"${OS_NAME}\":{[^}]*}" | grep -o "\"link\":\"[^\"]*" | sed 's/"link":"//' | sed -n '1p')
    rm -f pycharm-version.json

    wget -q ${LINK} -O pycharm.tar.gz

fi

tar -xzf pycharm.tar.gz
mv pycharm-* pycharm
rm -f pycharm.tar.gz

# 桌面快捷方式
cd ~/Desktop

cat > pycharm.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=PyCharm Professional
Comment=PyCharm Professional
Exec=/opt/pycharm/bin/pycharm.sh
Icon=/opt/pycharm/bin/pycharm.svg
Terminal=false
Type=Application
Categories=Application;Development;
EOF

chmod +x pycharm.desktop

# 破解
cd /opt

git clone https://github.com/libin9iOak/ja-netfilter-all.git

sh ja-netfilter-all/scripts/install.sh

mv /opt/pycharm/bin/pycharm64.vmoptions /opt/pycharm/bin/pycharm64.vmoptions_bk
cp /opt/ja-netfilter-all/vmoptions/pycharm.vmoptions /opt/pycharm/bin/pycharm64.vmoptions

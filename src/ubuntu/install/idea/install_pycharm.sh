#!/usr/bin/env bash
set -ex

# 安装最新的pycharm
cd /opt

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/x64/g')
ARCH_NAME=$(arch | sed 's/aarch64/linuxARM64/g' | sed 's/x86_64/linux/g')
if [ ! -f "pycharm-${ARCH}.tar.gz" ]; then
    curl --location --request GET 'https://data.services.jetbrains.com/products/releases?code=PCP&latest=true&type=release' -o pycharm-version.json

    LINK=$(cat pycharm-version.json | grep -o "\"${ARCH_NAME}\":{[^}]*}" | grep -o "\"link\":\"[^\"]*" | sed 's/"link":"//' | sed -n '1p')
    rm -f pycharm-version.json

    wget -q ${LINK} -O pycharm-${ARCH}.tar.gz
fi

tar -xzf pycharm-${ARCH}.tar.gz
mv pycharm-* pycharm
rm -f pycharm-${ARCH}.tar.gz

# 桌面快捷方式
if [ -d "~/Desktop" ]; then
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

fi
# 破解
cd /opt

git clone https://github.com/libin9iOak/ja-netfilter-all.git

sh ja-netfilter-all/scripts/install.sh

mv /opt/pycharm/bin/pycharm64.vmoptions /opt/pycharm/bin/pycharm64.vmoptions_bk
cp /opt/ja-netfilter-all/vmoptions/pycharm.vmoptions /opt/pycharm/bin/pycharm64.vmoptions

if [ -d "~/Desktop" ]; then
    cp /opt/ja-netfilter-all/readme.md ~/Desktop/pycharm_regiest_code.txt
fi
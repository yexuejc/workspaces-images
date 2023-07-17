#!/usr/bin/env bash
set -ex

if [ "$(arch)" == "aarch64" ] ; then
    OS_NAME=linuxARM64
else
    OS_NAME=linux
fi
# 安装最新的idea
cd /opt

if [ ! -f "idea.tar.gz" ]; then
    curl --location --request GET 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release' -o idea-version.json

    LINK=$(cat idea-version.json | grep -o "\"${OS_NAME}\":{[^}]*}" | grep -o "\"link\":\"[^\"]*" | sed 's/"link":"//' | sed -n '1p')
    rm -f idea-version.json

    wget -q ${LINK} -O idea.tar.gz

fi

tar -xzf idea.tar.gz
mv idea-* idea
rm -f idea.tar.gz

# 桌面快捷方式
cd ~/Desktop

cat > idea.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=/opt/idea/bin/idea.sh
Icon=/opt/idea/bin/idea.svg
Terminal=false
Type=Application
Categories=Application;Development;
EOF

chmod +x idea.desktop

# 破解
cd /opt

git clone https://github.com/libin9iOak/ja-netfilter-all.git

sh ja-netfilter-all/scripts/install.sh

mv /opt/idea/bin/idea64.vmoptions /opt/idea/bin/idea64.vmoptions_bk
cp /opt/ja-netfilter-all/vmoptions/idea.vmoptions /opt/idea/bin/idea64.vmoptions

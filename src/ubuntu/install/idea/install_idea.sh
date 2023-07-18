#!/usr/bin/env bash
set -ex

# 安装最新的idea
cd /opt
apt-get update

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/x64/g')
ARCH_NAME=$(arch | sed 's/aarch64/linuxARM64/g' | sed 's/x86_64/linux/g')
if [ ! -f "idea-${ARCH}.tar.gz" ]; then
    curl --location --request GET 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release' -o idea-version.json

    LINK=$(cat idea-version.json | grep -o "\"${ARCH_NAME}\":{[^}]*}" | grep -o "\"link\":\"[^\"]*" | sed 's/"link":"//' | sed -n '1p')
    rm -f idea-version.json

    wget -q ${LINK} -O idea-${ARCH}.tar.gz
fi

tar -xzf idea-${ARCH}.tar.gz
rm -f idea-${ARCH}.tar.gz
mv idea-* idea

# 破解
cd /opt

git clone https://github.com/libin9iOak/ja-netfilter-all.git

sh ja-netfilter-all/scripts/install.sh

mv /opt/idea/bin/idea64.vmoptions /opt/idea/bin/idea64.vmoptions_bk
cp /opt/ja-netfilter-all/vmoptions/idea.vmoptions /opt/idea/bin/idea64.vmoptions

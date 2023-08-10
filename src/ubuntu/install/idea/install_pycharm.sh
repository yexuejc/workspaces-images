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
rm -rf pycharm-${ARCH}.tar.gz
mv pycharm-* pycharm

# 破解
cd /opt

# check网站是否能ping通（下面2个命令都可，实测第二个好用）
# wget --quiet --spider --timeout=5 https://github.com/libin9iOak/ja-netfilter-all.git
curl --silent --output /dev/null --head --fail --max-time 5 https://github.com/libin9iOak/ja-netfilter-all.git

if [ $? = 0 ];then
    git clone https://github.com/libin9iOak/ja-netfilter-all.git
else
    git clone https://gitee.com/yexuejc/ja-netfilter-all.git
fi

sh ja-netfilter-all/scripts/install.sh

mv /opt/pycharm/bin/pycharm64.vmoptions /opt/pycharm/bin/pycharm64.vmoptions_bk
cp /opt/ja-netfilter-all/vmoptions/pycharm.vmoptions /opt/pycharm/bin/pycharm64.vmoptions

#!/usr/bin/env bash
set -ex

DESK=$HOME/Desktop
# 桌面快捷方式
if [ -d "${DESK}" ]; then
cd $DESK

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

cp /opt/ja-netfilter-all/readme.md $DESK/pycharm_regiest_code.txt

fi

#删除COPY进来的所有文件
cd  /opt
ls -p -l | grep - | grep -v / | awk '{print $NF}' | xargs -r rm
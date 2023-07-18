#!/usr/bin/env bash
set -ex

DESK=$HOME/Desktop
# 桌面快捷方式
if [ -d "${DESK}" ]; then
cd $DESK

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

cp /opt/ja-netfilter-all/readme.md $DESK/idea_regiest_code.txt

fi

#删除COPY进来的所有文件
cd  /opt
ls -p -l | grep - | grep -v / | awk '{print $NF}' | xargs -r rm
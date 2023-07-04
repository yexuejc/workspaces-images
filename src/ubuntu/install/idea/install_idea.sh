#!/bin/bash
set -ex

cd /opt

if [ "$(arch)" == "aarch64" ] ; then
    wget -q https://download.jetbrains.com/idea/ideaIU-2023.1.3-aarch64.tar.gz -O idea.tar.gz
else
    wget -q https://download.jetbrains.com/idea/ideaIU-2023.1.3.tar.gz -O idea.tar.gz
fi

tar -xzf idea.tar.gz
mv idea-* idea
rm -f idea.tar.gz

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





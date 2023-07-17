#!/bin/bash
set -ex

cd /opt

if [ ! -f "graalvm-java17.tar.gz" ]; then
    wget -q https://d6.injdk.cn/graal/vm-22.3.0/graalvm-ce-java17-linux-amd64-22.3.0.tar.gz -O graalvm-java17.tar.gz
fi
tar -xzf graalvm-java17.tar.gz
rm -rf graalvm-java17.tar.gz
mv graalvm-* graalvm-java17

echo "export JAVA_HOME=/opt/graalvm-java17" >> /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile

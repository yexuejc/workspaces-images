#!/bin/bash
set -ex

cd /opt

if [ ! -f "graalvm-java17.tar.gz" ]; then
    wget -q https://download.oracle.com/graalvm/17/latest/graalvm-jdk-17_linux-x64_bin.tar.gz -O graalvm-java17.tar.gz
fi
tar -xzf graalvm-java17.tar.gz
rm -rf graalvm-java17.tar.gz
mv graalvm-* graalvm-java17

echo "export JAVA_HOME=/opt/graalvm-java17" >> /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile

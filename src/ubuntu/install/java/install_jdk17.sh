#!/bin/bash
set -ex

cd /opt
apt update

if [ ! -f "openjdk17.tar.gz" ]; then
    apt install openjdk-17-jdk -y
    echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
else
    tar -xzf openjdk17.tar.gz
    rm -rf openjdk17.tar.gz
    mv jdk-* openjdk-17

    echo "export JAVA_HOME=/opt/openjdk-17" >> /etc/profile
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
fi


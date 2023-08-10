#!/bin/bash
set -ex

folder_path=/opt/wine-pkgs/after

if [ -d "$folder_path" ] && find "$folder_path" -maxdepth 1 -name "*.deb" -print -quit | grep -q .; then
    # 本地安装wineUI
    cd $folder_path
    dpkg -i WineGUI-*.deb && apt-get -f install
    rm -rf WineGUI-*.deb
else
    # 在线安装wineUI
    curl --location 'https://gitlab.melroy.org/api/graphql' \
        --header 'Content-Type: application/json' \
        --data '[{"operationName": "allReleases","variables": {"fullPath": "melroy/winegui","first": 1,"sort": "RELEASED_AT_DESC"},"query": "query allReleases($fullPath: ID!, $first: Int, $last: Int, $before: String, $after: String, $sort: ReleaseSort) { project(fullPath: $fullPath) { releases( first: $first last: $last before: $before after: $after sort: $sort ) { nodes { ...Release } } } } fragment Release on Release { assets { links { nodes { url } } } } "}]' \
        -o winegui-version.json

    if [[ "${DISTRO}" == @(centos|oracle8|rockylinux9|rockylinux8|oracle9|almalinux9|almalinux8) ]]; then
        link=$(cat winegui-version.json | grep -o '"url":"[^"]*"' | awk -F'"' '{print $4}' | grep rpm)
        wget -q ${link} -O winegui.rpm
        if [[ "${DISTRO}" == @(oracle8|rockylinux9|rockylinux8|oracle9|almalinux9|almalinux8) ]]; then
            dnf localinstall -y winegui.rpm
            if [ -z ${SKIP_CLEAN+x} ]; then
                dnf clean all
            fi
        else
            yum localinstall -y winegui.rpm
            if [ -z ${SKIP_CLEAN+x} ]; then
                yum clean all
            fi
        fi
        rm winegui.rpm
    else
        link=$(cat winegui-version.json | grep -o '"url":"[^"]*"' | awk -F'"' '{print $4}' | grep deb)
        wget -q ${link} -O winegui.deb
        apt-get install -y ./winegui.deb
        rm winegui.deb
        if [ -z ${SKIP_CLEAN+x} ]; then
            apt-get autoclean
            rm -rf \
                /var/lib/apt/lists/* \
                /var/tmp/*
        fi
    fi
    rm -f winegui-version.json
fi

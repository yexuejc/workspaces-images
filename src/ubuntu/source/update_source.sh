#!/bin/bash
set -ex

# 自动选择源
# ===========================================================

if [ -d $INST_SCRIPTS/source/ ]; then
    cp $INST_SCRIPTS/source/source.list* /etc/apt/
    cp -f /etc/apt/sources.list /etc/apt/sources.list.default
fi

vname=$(lsb_release -cs)

folder_path=/etc/apt/
# 获取以source.list开头的文件列表
file_list=$(find "$folder_path" -maxdepth 1 -name "source.list*")

# 初始化延迟最小值和对应的域名和文件名
min_delay=-1
min_domain=""
min_file=""

# 遍历文件列表
for file_path in $file_list; do
    # 读取文件的第一行内容
    first_line=$(head -n 1 "$file_path")

    # 提取域名
    domain=$(echo "$first_line" | cut -d' ' -f2)

    # 进行ping操作并获取延迟
    delay=$(curl -o /dev/null -s -w "%{time_total}\n" "https://$domain" 2>/dev/null)

    # 判断延迟是否为最小值或未初始化
    if [ "$delay" != "" ] && ([[ $(bc <<<"$delay < $min_delay") -eq 1 ]] || [ "$min_delay" == -1 ]); then
        min_delay="$delay"
        min_domain="$domain"
        min_file="$file_path"
    fi
done

if [ "$min_file" == "/etc/apt/sources.list.default" ]; then
    cp -f $min_file /etc/apt/sources.list
else
    # 替换系统版本
    repv=$(head -n 2 "$min_file")
    if [ "$repv" != "$vname"]; then
        sed -i "s/$repv/$vname/g" $min_file
    fi
    # 输出延迟最小的域名对应的文件
    cp -f $min_file /etc/apt/sources.list
fi

# 说明文件
READ_ME=$HOME/source/update_source.txt
mkdir -p $HOME/source

if [ ! -f $READ_ME ]; then
    echo "替换数据源请执行: update_source.sh" >>$READ_ME
    cp $INST_SCRIPTS/source/update_source.sh $HOME/source/
fi
echo "$(date "+%Y-%m-%d %H:%M:%S")" >>$READ_ME
echo "替换源为: $min_file" >>$READ_ME
echo "延迟时间: $min_delay ms" >>$READ_ME
echo "" >>$READ_ME

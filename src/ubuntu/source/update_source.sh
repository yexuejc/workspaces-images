#!/bin/bash
set -ex

#自动选择源
cp source.list* /etc/apt/
cp -f /etc/apt/sources.list /etc/apt/sources.list.default
folder_path=/etc/apt/

# 获取以source.list开头的文件列表
file_list=$(find "$folder_path" -name "source.list*")

# 初始化延迟最小值和对应的域名和文件名
min_delay=-1
min_domain=""
min_file=""

# 获取以source.list开头的文件列表
file_list=$(find "$folder_path" -name "source.list*")

# 遍历文件列表
for file_path in $file_list; do
    # 读取文件的第一行内容
    first_line=$(head -n 1 "$file_path")
  
    # 提取域名
    domain=$(echo "$first_line" | cut -d' ' -f2)
  
    # 进行ping操作并获取延迟
    delay=$(ping -c 3 -q "$domain" | awk -F/ '/^rtt/ {print $5}')
  
    # 判断延迟是否为最小值或未初始化
    if [ "$delay" != "" ] && (($(bc <<< "$delay < $min_delay") || [ "$min_delay" == -1 ])); then
        min_delay="$delay"
        min_domain="$domain"
        min_file="$file_path"
    fi
done

# 输出延迟最小的域名对应的文件
echo "延迟最小的源为: $min_domain, 延迟时间: $min_delay ms"
echo "替换源为: $min_file"
cp -f $min_file /etc/apt/sources.list

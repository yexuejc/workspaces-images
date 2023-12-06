## 编译
cd workspaces-images/

* 本地安装包版本：
> 1.idea-x64.tar.gz                     -> ideaIU-2023.1.3.tar.gz
> 2.graalvm-java17.tar.gz               -> graalvm-ce-java17-linux-amd64-22.3.0.tar.gz
> 3.openjdk17.tar.gz                    -> openjdk-17.0.1_linux-x64_bin.tar.gz
> 4.vs_code_x64.deb                     -> code_1.79.2-1686734195_amd64.deb
> 5.pycharm-x64.tar.gz                  -> pycharm-professional-2023.1.4.tar.gz
> 6.google.deb                          -> google-chrome-stable_current_amd64.deb
> 7.google.rpm                          -> google-chrome-stable_current_x86_64.rpm
> 8.wine/*                              -> 2023/07/19版本
> 8.wine/after/WineGUI-v2.1.0.deb       -> 2023/07/19版本

* kasm-ubuntu-develop 里面有可选项：
> java : 默认OpenJdk,可选GraalVM Jdk
> idea : 默认在线安装；可先下载到本地dev.04
> 文本编辑器：默认vs code;可不装
> chrome : 默认在线安装；可先下载到本地
> wine : 默认在线安装；可先下载到本地

https://pan.quark.cn/s/21538580c53a

---
##### kasm-ubuntu-develop增加程序rdesktop
docker build -t yexuejc/kasm-ubuntu-develop:dev.04 -f dockerfile-kasm-develop .

docker run --rm  -it --shm-size=512m -p 6902:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-develop:dev.04

---

## kasm-ubuntu-develop
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，vs code文本编辑器，Jetbrains IntelliJ IDEA,Wine

#### 使用
```
docker run -itd --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=admin registry.cn-chengdu.aliyuncs.com/yexuejc/kasm-ubuntu-develop:dev.04
```

#### 账号密码
VNC： kasm_user/password
用户： kasm-user/password
可以使用环境变量修改：
```
VNC_PW=password
USER_PWD=passwd
```

---

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

* kasm-ubuntu-idea 里面有可选项：
> java : 默认OpenJdk,可选GraalVM Jdk
> idea : 默认在线安装；可先下载到本地
> 文本编辑器：默认vs code;可不装

* kasm-ubuntu-pycharm 里面有可选项：
> pycharm : 默认在线安装；可先下载到本地

* kasm-ubuntu-wine 里面有可选项：
> chrome : 默认在线安装；可先下载到本地
> wine : 默认在线安装；可先下载到本地
> 文本编辑器：默认vs code;可选择sublime

https://pan.quark.cn/s/21538580c53a

---
##### 增加不同jdk的版本，支持离线安装
docker build -t yexuejc/kasm-ubuntu-idea:graalvmjdk17 -f dockerfile-kasm-idea-graalvmjdk17 .
docker build -t yexuejc/kasm-ubuntu-idea:openjdk17 -f dockerfile-kasm-idea-openjdk17 .

docker tag yexuejc/kasm-ubuntu-idea:graalvmjdk17 registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:graalvmjdk17
docker tag yexuejc/kasm-ubuntu-idea:openjdk17 registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:openjdk17

docker push registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:graalvmjdk17
docker push registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:openjdk17

docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-idea:graalvmjdk17

---
##### 新增pycharm
docker build -t yexuejc/kasm-ubuntu-pycharm:dev.02 -f dockerfile-kasm-pycharm .

docker run --rm  -it --shm-size=512m -p 6902:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-pycharm:dev.02

---
##### 支持离线安装,install_sublime_text替换成vs code
docker build -t yexuejc/kasm-ubuntu-wine:dev.02 -f dockerfile-kasm-wine .

docker run --rm  -it --shm-size=1024m -p 6902:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-wine:dev.02

---

## kasm-ubuntu-idea
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，sublime文本编辑器，Jetbrains IntelliJ IDEA

#### 使用
```
docker run -itd --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=admin registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:graalvmjdk17
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

## kasm-ubuntu-pycharm
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，sublime文本编辑器，Jetbrains Pycharm

#### 使用
```
docker run -itd --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=admin registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-pycharm:dev.02
```

#### 账号密码
VNC： kasm_user/password
用户： kasm-user/password
可以使用环境变量修改：
```
VNC_PW=password
USER_PWD=passwd
```
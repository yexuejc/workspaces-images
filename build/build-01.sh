## 编译
cd workspaces-images/

docker build -t yexuejc/kasm-ubuntu-wine:dev.01 -f dockerfile-kasm-wine .
docker build -t yexuejc/kasm-ubuntu-idea:dev.01 -f dockerfile-kasm-idea .


docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-idea:dev.01
docker run --rm  -it --shm-size=512m -p 6902:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-wine:dev.01
---

## kasm-ubuntu-wine
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，sublime文本编辑器，wine

#### 使用
```
docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-wine:dev.01
```

#### 账号密码
VNC：kasm_user/password
用户：kasm-user/password
可以使用环境变量修改：
```
VNC_PW=password
USER_PWD=passwd
```
---
## kasm-ubuntu-idea
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，sublime文本编辑器，Jetbrains IntelliJ IDEA

#### 使用
```
docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:dev.01
```

#### 账号密码
VNC：kasm_user/password
用户：kasm-user/password
可以使用环境变量修改：
```
VNC_PW=password
USER_PWD=passwd
```


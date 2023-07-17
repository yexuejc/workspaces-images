## 编译
cd workspaces-images/

# 本地安装包版本：
# 1.idea.tar.gz             -> ideaIU-2023.1.3.tar.gz
# 2.graalvm-java17.tar.gz   -> graalvm-ce-java17-linux-amd64-22.3.0.tar.gz
# 2.vs_code_x64.deb         -> code_1.79.2-1686734195_amd64.deb

# kasm-ubuntu-idea 里面有可选项：
# java : 默认OpenJdk,可选GraalVM Jdk
# idea : 默认在线安装；可先下载到本地
# 文本编辑器：默认vs code;可不装
docker build -t yexuejc/kasm-ubuntu-idea:dev.02 -f dockerfile-kasm-idea .

docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/kasm-ubuntu-idea:dev.02

---

## kasm-ubuntu-idea
基于ubuntu:20.04 安装kasm工具，xfce桌面，chrome浏览器，sublime文本编辑器，Jetbrains IntelliJ IDEA

#### 使用
```
docker run -itd --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=admin registry.cn-hangzhou.aliyuncs.com/yexuejc/kasm-ubuntu-idea:dev.02
```

#### 账号密码
VNC：kasm_user/password
用户：kasm-user/password
可以使用环境变量修改：
```
VNC_PW=password
USER_PWD=passwd
```


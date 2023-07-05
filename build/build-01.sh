cd workspaces-images/

docker build -t yexuejc/dockerfile-kasm-wine:dev.01 -f dockerfile-kasm-wine .

docker build -t yexuejc/dockerfile-kasm-idea:dev.01 -f dockerfile-kasm-idea .


docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password -e USER_PWD=passwd yexuejc/dockerfile-kasm-idea:dev.01
docker run --rm  -it --shm-size=512m -p 6902:6901 -e VNC_PW=password yexuejc/dockerfile-kasm-wine:dev.01


kasm_user
password

docker login --username=*****@qq.com registry.cn-hangzhou.aliyuncs.com
docker tag yexuejc/dockerfile-kasm-wine:dev.01 registry.cn-hangzhou.aliyuncs.com/yexuejc/dockerfile-kasm-wine:dev.01
docker push registry.cn-hangzhou.aliyuncs.com/yexuejc/dockerfile-kasm-wine:dev.01

docker tag yexuejc/dockerfile-kasm-idea:dev.01 registry.cn-hangzhou.aliyuncs.com/yexuejc/dockerfile-kasm-idea:dev.01
docker push registry.cn-hangzhou.aliyuncs.com/yexuejc/dockerfile-kasm-idea:dev.01
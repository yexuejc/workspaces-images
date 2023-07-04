cd workspaces-images/

docker build -t yexuejc/dockerfile-kasm-wine:dev.0703 -f dockerfile-kasm-wine .


docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password yexuejc/dockerfile-kasm-wine:dev.0703
docker run --rm  -it --shm-size=512m -p 6902:6901 -e VNC_PW=password yexuejc/dockerfile-kasm-wine:dev.0704
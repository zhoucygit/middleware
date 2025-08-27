FROM docker.m.daocloud.io/library/alpine:latest
USER root
# 安装jdk8
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --no-cache openjdk8 tcpdump curl busybox-extras bash  tzdata bash vim  wget net-tools fontconfig mkfontscale ttf-dejavu && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir /app  && \
    echo 'alias "ll=ls -l"' >> /etc/bash/bashrc && \
    echo 'alias "tailf=tail -f"' >> /etc/bash/bashrc && \
    mkfontscale && mkfontdir && fc-cache && fc-cache -fv
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
ADD windows /usr/share/fonts/windows

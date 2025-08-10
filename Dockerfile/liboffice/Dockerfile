FROM docker.1ms.run/linuxserver/libreoffice:25.2.5
USER root
# 安装jdk8
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --no-cache curl busybox-extras bash openjdk8  tzdata bash vim  wget net-tools fontconfig mkfontscale ttf-dejavu && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && \
    echo 'alias "ll=ls -l"' >> /etc/bash/bashrc && \
    echo 'alias "tailf=tail -f"' >> /etc/bash/bashrc && \
    mkfontscale && \
    mkfontdir && \
    fc-cache && \
    fc-cache -fv
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
ADD config /app/config
WORKDIR /app
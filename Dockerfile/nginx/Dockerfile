FROM docker.m.daocloud.io/library/alpine:latest
USER root

    
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8


RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --no-cache tcpdump curl busybox-extras bash  tzdata bash vim  wget net-tools \
    patch \
    gcc \
    g++ \
    automake \
    pcre \
    pcre-dev \
    zlib \
    zlib-dev \
    openssl \
    openssl-dev \
    make && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir /app  && \
    echo 'alias "ll=ls -l"' >> /etc/bash/bashrc && \
    echo 'alias "tailf=tail -f"' >> /etc/bash/bashrc 
    cd /tmp/nginx-1.22.1 && \
    mkdir /middleware && \
    patch -p1 < /tmp/nginx_upstream_check_module-master/check_1.20.1+.patch && \
    ./configure \
     --user=root \
     --group=root \
     --prefix=/middleware/nginx \
     --with-http_stub_status_module \
     --with-http_sub_module \
     --with-http_ssl_module \
     --with-http_realip_module \
     --with-pcre  \
     --with-stream  \
     --with-http_v2_module \
     --with-http_stub_status_module \
     --with-cc-opt='-fprofile-generate -fprofile-dir=./objs' --with-ld-opt='-lgcov'  \
     --add-module=/tmp/nginx-module-vts-master   \
     --add-module=/tmp/nginx_upstream_check_module-master && \
     make && make install && \
     mkdir /middleware/nginx/conf.d && \
     mkdir /middleware/nginx/stream.d && \
     sed -i "s#js;#js mjs;#g"   /middleware/nginx/conf/mime.types && \
     rm -rf /tmp/* 

ADD nginx.conf /middleware/nginx/conf/nginx.conf && \
ADD default.conf /middleware/nginx/conf.d/default.conf && \
CMD ["/middleware/nginx/sbin/nginx", "-g", "daemon off;"]
FROM ubuntu                                                                    
USER root

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ADD nginx-1.22.1 /tmp/nginx-1.22.1
ADD nginx-module-vts-master /tmp/nginx-module-vts-master
ADD nginx_upstream_check_module-master /tmp/nginx_upstream_check_module-master

RUN sed -i 's|http://.*.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        nocache \
        curl  \
        tcpdump \
        locales \
        tzdata \
        telnet
        wget \
        vim \
        net-tools \
        gcc libpcre3 libpcre3-dev libssl-dev zlib1g-dev  make && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    ln -sf /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* && \
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
     sed -i "s#js;#js mjs;#g"   /etc/nginx/mime.types && \
     rm -rf /tmp/* 

ADD nginx.conf /middleware/nginx/conf/nginx.conf && \
ADD default.conf /middleware/nginx/conf.d/default.conf && \
CMD ["nginx", "-g", "daemon off;"]



FROM ubuntu:24.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ADD ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources
RUN  apt-get update --allow-unauthenticated && \
     apt-get install -y --no-install-recommends ca-certificates && \
     update-ca-certificates  apt-get update && \
     apt-get install -y --no-install-recommends \
        nocache \
        fontconfig \
        curl  \
        telnet \
        tcpdump \
        locales \
        tzdata \
        wget \
        vim \
        unzip \
        openjdk-11-jdk \
        net-tools && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
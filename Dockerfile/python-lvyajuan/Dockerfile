#  仓库地址 http://gitlab.tydiczt.cn/intelligent-evaluation/backend/table_parse_opencv.git,

FROM nvidia/cuda:12.3.2-base-ubuntu22.04                                                                     
USER root

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

COPY requirements.txt /tmp/

RUN sed -i 's|http://.*.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        nocache \
        curl  \
        tcpdump \
        locales \
        tzdata \
        python3 python3-pip \
        wget \
        vim \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
        net-tools && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    ln -sf /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install --no-cache-dir    --break-system-packages   -r /tmp/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ && \
    rm -rf /tmp/requirements.txt
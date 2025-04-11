FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04
USER root
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
RUN sed -i 's|http://.*.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list  && \
apt update  && apt install -y wget locales vim net-tools &&  \
locale-gen en_US.UTF-8 && \
update-locale LANG=en_US.UTF-8 && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
chmod 777 ~/miniconda.sh && \
ln -sf /bin/bash /bin/sh && \
bash ~/miniconda.sh -b -p /opt/miniconda && \
eval "$(/opt/miniconda/bin/conda shell.bash hook)" && \
conda init && \
rm -rf ~/miniconda.sh  && \
/opt/miniconda/bin/pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r/  && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/ && \
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
conda config --set show_channel_urls yes
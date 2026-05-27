FROM nlpbase/cuda_miniconda:latest
USER root
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
ADD entrypoint.sh /entrypoint.sh
RUN apt-get update && apt-get install -y libnuma1 libgl1 libglib2.0-0 && chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]



# 自定义基础惊险个，改方式将envs路径挂载上去即可
FROM cuda_miniconda3:12.4.1-cudnn-devel-ubuntu22.04
USER root
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
ADD entrypoint.sh /entrypoint.sh
RUN mv /etc/apt/sources.list.d/cuda-ubuntu2204-x86_64.list /tmp/cuda-ubuntu2204-x86_64.list &&  apt-get update && apt-get install -y libnuma1 libgl1 libglib2.0-0 && chmod +x /entrypoint.sh &&  mv /tmp/cuda-ubuntu2204-x86_64.list /etc/apt/sources.list.d/cuda-ubuntu2204-x86_64.list
ENTRYPOINT ["/entrypoint.sh"]
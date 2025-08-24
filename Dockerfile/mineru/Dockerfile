FROM nlpbase/cuda_miniconda:latest
USER root
ENV TZ=Asia/Shanghai 
ENV LANG=en_US.UTF-8  
ENV LC_ALL=en_US.UTF8
ADD entrypoint.sh /entrypoint.sh
RUN apt-get update && apt-get install  nocache -y libnuma1 libgl1 libglib2.0-0 && chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
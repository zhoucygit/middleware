# RockerMQ 单机版部署脚本
第一次使用要先修改init.sh脚本中brokerip地址，并通过该脚本运行，该脚本主要帮我们做了一下内容
- 创建rocketmq持久化需要的本地路径
- 修改该本地路径权限为777
- 修改broker配置文件中地址为本机地址
- 启动docker容器

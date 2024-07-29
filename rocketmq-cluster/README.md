# RockerMQ 单机版部署脚本
第一次使用要先修改init.sh脚本中brokerip地址，并通过该脚本运行，该脚本主要帮我们做了一下内容
- 创建rocketmq持久化需要的本地路径
- 修改该本地路径权限为777
- 修改broker配置文件中地址为本机地址
- 启动docker容器


# 日常维护
第一次启动成功后后续日常维护可以通过以下命令完成

# 重启应用
- 重启所有应用
进入到脚本目录下运行一下命令
```
docker compose -f docker-compose.yaml restart 
```
- 重启某一应用
```
查看容器名称
docker ps | grep rocket
docker  restart 容器名称
```
# 停止应用
- 停止所有应用

进入到脚本目录下运行一下命令
```
docker compose -f docker-compose.yaml down
```
- 停止某一应用
```
查看容器名称
docker ps | grep rocket
docker  stop 容器名称
```

# 启动供应用
- 启动所有应用
如果所有应用处于停止状态，并且不是第一次启动，可以通过以下方式启动
进入到脚本目录下运行一下命令
```
docker compose -f docker-compose.yaml up -d
```
- 启动某一应用
```
查看容器名称
docker ps | grep rocket
docker  start 容器名称
```
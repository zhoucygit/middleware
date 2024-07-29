# RockerMQ 集群版部署脚本使用方法

## 修改初始化文件
- 修改该init-host-a.sh 以及init-host-a.sh初始化文件中以下两项的值
```
HOSTIP1=192.168.10.129
HOSTIP2=192.168.10.130
```
## 执行脚本
- 在host-a 上执行init-host-a.sh，在host-b上执行init-host-b.sh

# 脚本说明
该脚本主要帮我们做了以下操作
- 创建rocketmq持久化需要的本地路径
- 修改该本地路径权限为777
- 修改broker配置文件中broker地址为本机地址
- 修改该nameserver地址为集群中两台主机地址
- 修改该配置文件中角色为maseter或slave
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
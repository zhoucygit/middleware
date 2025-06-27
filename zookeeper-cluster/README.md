# 安装说明
如果是集群，需要更改每台机器上的docker-compose.yml文件中以下内容
- hostname对应的名称要更改
- hosts映射要更改，每台机器更改为如下内容,注意ip改为实际ip
```
zookeeper-a 改为如下所示
    extra_hosts:
      - "zookeeper-b:10.100.15.22"
      - "zookeeper-c:10.100.15.23"
zookeeper-b 改为如下所示
    extra_hosts:
      - "zookeeper-a:10.100.15.22"
      - "zookeeper-c:10.100.15.23"
zookeeper-c 改为如下所示
    extra_hosts:
      - "zookeeper-a:10.100.15.22"
      - "zookeeper-b:10.100.15.23"
```
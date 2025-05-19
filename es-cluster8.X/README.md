# 说明
8.X ES默认启用认证，并使用https协议，因此集群方式需要先生成证书，访问时需要带上证书及认证

# 生成证书

## 创建生成证书的临时容器
docker run -itd --name estest 192.168.10.212/middleware/elasticsearch_arm64:8.13.4 bash

## instances.yml内容如下

```
docker exec -it estest bash
cat > instances.yml <<EOF
instances:
  - name: es-nodes
    ip:
      - 10.100.12.201
      - 10.100.12.202
      - 10.100.12.203
      - 127.0.0.1
    dns:
      - localhost
EOF
```
## 生成证书文件
```
bin/elasticsearch-certutil ca --silent --pem -out /tmp/ca.zip &&
unzip /tmp/ca.zip -d /tmp/ &&
bin/elasticsearch-certutil cert --silent --pem --in ./instances.yml --ca-cert /tmp/ca/ca.crt --ca-key /tmp/ca/ca.key -out /tmp/bundle.zip &&
unzip /tmp/bundle.zip -d /tmp/ &&
mkdir /tmp/certs &&
cp -a /tmp/ca /tmp/certs &&
cp /tmp/es-nodes/* /tmp/certs
```


## 将生成的证书放到certs路径下
docker cp estest:/tmp/certs ./
将证书分发到起他机器

# 执行初始化脚本部署集群



# 验证
因为证书是私有证书，所以验证的时候要先把证书搞出来
```
docker cp elasticsearch:/usr/share/elasticsearch/config/certs/http_ca.crt .
curl --cacert http_ca.crt -u elastic:010.Tydic https://localhost:9200
```

# 依赖
ES启动需要设只内核参数
如果启动报错
```
ERROR: Elasticsearch exited unexpectedly, with exit code 78
```
通过以下方式解决
```
sudo sysctl -w vm.max_map_count=262144
```



# 进入容器

```
 docker exec -it elasticsearch bash

```

 # 生成秘钥

```
如果版本不对，有可能需要重新生成秘钥文件，秘钥文件生成方式为
./bin/elasticsearch-certutil cert -out  config/elastic-certificates.p12 -pass
```

 # 设置密码
 
```
./bin/elasticsearch-setup-passwords interactive
```


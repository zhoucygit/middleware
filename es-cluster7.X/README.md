# 说明
8.X ES默认启用认证，并使用https协议，因此访问时需要带上证书及认证

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


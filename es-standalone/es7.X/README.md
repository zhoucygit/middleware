# 创建挂载路径并更改权限
创建路径
```
mkdir ES_plugins ES_DATA
```
更改权限为777 
```
chmod 777 ES_plugins ES_DATA
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




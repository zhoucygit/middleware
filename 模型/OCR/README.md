# 负载
如果是多实例需要负载，可以将nginx-compose.yml中内容加入docker-compose.yml中

# ocr验证方法
```
curl --request POST \
  --url http://10.133.113.242:28080/ocr/upload \
  --header 'content-type: multipart/form-data' \
  --form files=@/data/softpackage/test.jpg \
  --form source=false \
  --form useCuda=true
```
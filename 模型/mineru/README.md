在 172.168.1.238 的/data/Mineru2.0/package路径下有之前制作镜像的文件


# 部署
不用多实例的话只要docker-compose即可

# mineru验证方法

```
curl -X 'POST' \
  'http://10.133.113.242:20000/file_parse' \
  -H 'accept: application/json' \
  -H 'Content-Type: multipart/form-data' \
  -F 'return_middle_json=true' \
  -F 'return_model_output=true' \
  -F 'return_md=true' \
  -F 'return_images=true' \
  -F 'end_page_id=10' \
  -F 'parse_method=auto' \
  -F 'start_page_id=0' \
  -F 'lang_list=ch' \
  -F 'output_dir=/data/output' \
  -F 'server_url=http://10.133.113.242:30000' \
  -F 'return_content_list=true' \
  -F 'backend=vlm-sglang-client' \
  -F 'table_enable=true' \
  -F 'files=@/data/softpackage/test.pdf' \
  -F 'formula_enable=true'
```
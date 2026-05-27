在 172.168.1.238 的/data/Mineru2.0/package路径下有之前制作镜像的文件
#  说明
mineru3.1.15对 vllm 有要求，必须是 >= 0.10.1  而 vllm 0.9.2 之后驱动版本要 13.X
compute_capability: 12.0 >= 8.0 and vllm version: 0.21.0 >= 0.10.1, enable custom_logits_processors
 
# 部署

- 下载模型
我当前使用的 mineru3.1.15,使用以下两个模型即可
去魔搭网站下载一下两个模型（可以先搜索，使用最新版本即可）
PDF-Extract-Kit-1.0   
MinerU2.5-2509-1.2B

- 准备模板
  手工准备
 不同版本使用的模板不同，以下网站对应的是最新版本模板
 https://gcore.jsdelivr.net/gh/opendatalab/MinerU@master/mineru.template.json
  
  自动下载
 能联网的情况在去下载模型的话会自动下载对应的模板

- 修改模板
  只需要修改以下部分即可，将模型挂载到容器内后的地址是多少
```
      "models-dir": {
        "pipeline": "/modles/PDF-Extract-Kit-1.0",
        "vlm": "/modles/MinerU2.5-2509-1.2B"
    }
```

- 启动模型
  启动模型的时候要设置环境变量MINERU_MODEL_SOURCE=local  指定 mineru 使用本地模型


# mineru验证方法


- sglang 方式

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
- vllm 方式

```
curl --request POST \
  --url http://172.168.1.232:20000/file_parse \
  --header 'Accept: */*' \
  --header 'Accept-Encoding: gzip, deflate, br' \
  --header 'Connection: keep-alive' \
  --header 'User-Agent: PostmanRuntime-ApipostRuntime/1.1.0' \
  --header 'accept: application/json' \
  --header 'content-type: multipart/form-data' \
  --form return_middle_json=true \
  --form return_model_output=true \
  --form return_md=true \
  --form return_images=true \
  --form end_page_id=10 \
  --form parse_method=auto \
  --form start_page_id=0 \
  --form lang_list=ch \
  --form output_dir=/data/output \
  --form server_url=http://172.168.1.232:30000 \
  --form return_content_list=true \
  --form backend=vlm-http-client \
  --form table_enable=true \
  --form 'files=@/data/softpackage/test.pdf' \
  --form formula_enable=true
```
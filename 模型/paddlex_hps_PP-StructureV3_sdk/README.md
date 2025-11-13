# 版面分析模型部署  

# 下载介质
官方文档
https://paddlepaddle.github.io/PaddleX/latest/pipeline_deploy/serving.html#23

官方文档中下载sdk包 ： 通用版面解析 v3	paddlex_hps_PP-StructureV3_sdk.tar.gz

# 部署及配置
解压包将docker-compose.yml文件放入解压后的文件夹内
更改配置文件决定占用那块卡以及启动多少个实例

在高稳定性服务化部署 SDK 的 server/model_repo/{端点名称} 目录中，可以找到一个或多个 config*.pbtxt 文件。如果目录中存在 config_{设备类型}.pbtxt 文件，请修改期望使用的设备类型对应的配置文件；否则，请修改 config.pbtxt。
一个常见的需求是调整执行实例数量。为了实现这一点，需要修改配置文件中的 instance_group 配置，使用 count 指定每一设备上放置的实例数量，

使用 kind 指定设备类型，使用 gpus 指定 GPU 编号。示例如下：
本项目中修改的文件路径是 ./server/model_repo/layout-parsing/config_gpu.pbtxt
配置举例如下
```
在 GPU 0 上放置 4 个实例：
instance_group [
{
    count: 4
    kind: KIND_GPU
    gpus: [ 0 ]
}
]
在 GPU 1 上放置 2 个实例，在 GPU 2 和 3 上分别放置 1 个实例：
instance_group [
{
    count: 2
    kind: KIND_GPU
    gpus: [ 1 ]
},
{
    count: 1
    kind: KIND_GPU
    gpus: [ 2, 3 ]
}
]
```



# 个性化

吕亚娟对配置文件做了一些更改，将本工程内提供的pipeline_config.yaml 替换 原本server文件夹内的文件
她可能主要做了以下修改该
```
use_doc_preprocessor: False
use_seal_recognition: False
use_table_recognition: True
use_formula_recognition: False
use_chart_recognition: False
use_region_detection: True

1: "union"  # image
8: "small"  # table
```



# 编译模型

第一次启动容器他会根据环境编译并下载模型，
如果离线环境应当提前准备该.paddlex离线模型文件



# 验证

客户端提供java调用接口：http://127.0.0.1:8000/v2/models/layout-parsing/infer
入参
```
{
 "inputs": [
  {
  "name": "input",
   "shape": [1, 1],
   "datatype": "BYTES",
   "data": [
    "{\n  \"file\": \"http://127.0.0.1:18800/test.png\",\n  \"useDocOrientationClassify\": true,\n  \"useDocUnwarping\": false,\n   \"visualize\": false\n}"
   ]
  }
 ],
 "outputs": [
  {
   "name": "output"
  }
 ]
}
```


可以通过以下方式进行验证
1. 上传一张test.png 图片
2. 在刚才test.png图片的同路径执行   （python2.7) python -m SimpleHTTPServer 18800 或（python3)  python -m http.server 18800  
3. 通过以下curl 命令进行验证
```
curl --request POST \
  --url http://127.0.0.1:8000/v2/models/layout-parsing/infer \
  --header 'Accept: */*' \
  --header 'Accept-Encoding: gzip, deflate, br' \
  --header 'Connection: keep-alive' \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: PostmanRuntime-ApipostRuntime/1.1.0' \
  --data '{
 "inputs": [
  {
  "name": "input",
   "shape": [1, 1],
   "datatype": "BYTES",
   "data": [
    "{\n  \"file\": \"http://127.0.0.1:18800/test.png\",\n  \"useDocOrientationClassify\": true,\n  \"useDocUnwarping\": false,\n   \"visualize\": false\n}"
   ]
  }
 ],
 "outputs": [
  {
   "name": "output"
  }
 ]
}'
```
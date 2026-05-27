# 版面分析模型部署  

paddlex  到 3.5版本的   还不支持 5090
# 安装

 - 创建虚拟环境
 - 安装飞桨框架
   - gpu
     建议使用官方提供的镜像
     截止到 3.5版本，还不支持 5090 这种新架构的 gpu
   - npu
    查看https://github.com/PaddlePaddle/PaddleX/blob/release/3.0/docs/practical_tutorials/high_performance_npu_tutorial.md
   ```
    * 注意需要先安装飞桨 cpu 版本
    python -m pip install paddlepaddle==3.0.0.dev20250430 -i https://www.paddlepaddle.org.cn/packages/nightly/cpu
    python -m pip install paddle-custom-npu -i https://www.paddlepaddle.org.cn/packages/nightly/npu

    #CANN-8.0.RC2 对 numpy 和 opencv 部分版本不支持，需要安装指定版本
    python -m pip install numpy==1.26.4 opencv-python==3.4.18.65 -i https://pypi.tuna.tsinghua.edu.cn/simple

    arm机器上需要设置环境变量（x86环境无需设置）
    
    # 解决libgomp在arm机器上报错
    # "libgomp cannot allocate memory in static TLS block"
    export LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libgomp.so.1:$LD_PRELOAD
    验证安装包安装完成之后，运行如下命令
    
    python -c "import paddle; paddle.utils.run_check()"
    预期得到如下输出结果
    
    Running verify PaddlePaddle program ...
    PaddlePaddle works well on 1 npu.
    PaddlePaddle works well on 8 npus.
    PaddlePaddle is installed successfully! Let's start deep learning with PaddlePaddle now.
   ```




 - 安装 paddlex
   - gpu 安装
      强烈建议使用官方现成的镜像
   - npu安装
   ```
   pip install "paddlex[base]"

   ```
   说明
     - 仅安装必须依赖（可以在之后按需安装可选依赖）
     ```
     pip install paddlex
     ```
     - 安装 PaddleX “基础功能”需要的全部依赖：
     ```
     pip install "paddlex[base]"
     ```
     - 仅安装某项功能所需依赖：
     ```
     pip install "paddlex[ocr]"
     ```
   - npu安装


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

# 模型下载
paddlex  主要使用以下模型文件，第一次启动会自动从 modlescope 下载，为了节省时间，可以使用准备好的离线模型
```
PP-DocBlockLayout/
PP-DocLayout_plus-L/
PP-FormulaNet_plus-L/
PP-LCNet_x1_0_doc_ori/
PP-LCNet_x1_0_table_cls/
PP-LCNet_x1_0_textline_ori/
PP-OCRv5_server_det/
PP-OCRv5_server_rec/
RT-DETR-L_wired_table_cell_det/
RT-DETR-L_wireless_table_cell_det/
SLANet_plus/
SLANeXt_wired/
UVDoc/

```


# 个性化

吕亚娟对配置文件做了一些更改
主要做了以下修改该
```

原
use_formula_recognition: True
改为
use_formula_recognition: False

原      
1: "large"  # image
改为
1: "union"  # image

原
8: "union"  # table
改为
8: "small"  # table
```


# 指定模型路径

paddlex 有  bug
pipeline_config.yaml 改完后只是在加载阶段使用了本地模型 
所以模型路径还是要挂在到他的默认模型路径/root/.paddlex/official_models

  以上模型是个性化之后的模型列表，在pipeline_config.yaml  问价中搜索相关模型名称，更改 model_dir 对应的值，默认是 null
  示例：
  ```
    model_name: PP-DocLayout_plus-L
    model_dir: /root/.paddlex/official_models/PP-DocLayout_plus-L
  ```






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
    "{\n  \"file\": \"https://paddle-model-ecology.bj.bcebos.com/paddlex/imgs/demo_image/general_ocr_001.png\",\n  \"useDocOrientationClassify\": true,\n  \"useDocUnwarping\": false,\n   \"visualize\": false\n}"
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
用curl返回结果可能会是以下内容,用api工具可以看到真实内容
```
Warning: Binary output can mess up your terminal. Use "--output -" to tell 
Warning: curl to output it to your terminal anyway, or consider "--output 
Warning: <FILE>" to save to a file.
```
# 使用说明
# 更改config.json
更改之前需要确认config.json文件权限属性为650 , 否则模型起不来
```
-rw-r----- 1 root root 3851 Oct 15 07:22 cat_config.json
```
更改 conf文件夹中json文件，主要修改以下几项
1、 端口 

容器必须使用host网络，如果启用多个模型一定要注意修改该端口
```
"ipAddress" : "10.25.208.4",
"port" : 19999,
"managementPort" : 1026,
"metricsPort" : 1027,
```
2、 模型名称模型地址 
```
"modelName" : "tianshu-14b-std-cat-v3",
"modelWeightPath" : "/models/tianshu-14b-std-cat-v3-0126",
```
3、卡号设置
想用几号卡需要再列表中写好并且设置worldSize数量与卡数量一致
```
"npuDeviceIds" : [[4]],
"worldSize" : 1,
```

4、 禁用https
```
 "httpsEnabled" : false,
 "interCommTLSEnabled" : false,
```

5、设置token相关大小
注：该部分设置最好根据实际情况咨询专业算法工程师
```
"maxSeqLen" : 2048,
"maxInputTokenLen" : 1024,
"maxPrefillTokens" : 2048,
```

# 更改模型权限
将模型所有文件权限更改为750，如下所示
```
(base) [root@COFCO-YFIDC-N04-02U-BMS-A800-04 models]# ll
total 8
drwxr-xr-x 2 root root   29 Oct 15 08:51 logs
drwxr-x--- 2 root root 4096 Oct 15 03:04 tianshu-14b-std-attr-v4-2-0401
drwxr-x--- 2 root root 4096 Oct 15 03:25 tianshu-14b-std-cat-v3-0126
(base) [root@COFCO-YFIDC-N04-02U-BMS-A800-04 models]# ll tianshu-14b-std-cat-v3-0126/
total 54668216
-rwxr-x--- 1 root root        605 Feb  5  2025 added_tokens.json
-rwxr-x--- 1 root root      24072 Feb  5  2025 args.json
-rwxr-x--- 1 root root        761 Oct 15 03:10 config.json
-rwxr-x--- 1 root root        243 Feb  5  2025 generation_config.json
-rwxr-x--- 1 root root    1671853 Feb  5  2025 merges.txt
-rwxr-x--- 1 root root 4986100296 Feb  5  2025 model-00001-of-00012.safetensors
-rwxr-x--- 1 root root 4813111096 Feb  5  2025 model-00002-of-00012.safetensors
-rwxr-x--- 1 root root 4970415952 Feb  5  2025 model-00003-of-00012.safetensors
-rwxr-x--- 1 root root 4938953008 Feb  5  2025 model-00004-of-00012.safetensors
-rwxr-x--- 1 root root 4970415984 Feb  5  2025 model-00005-of-00012.safetensors
-rwxr-x--- 1 root root 4938953008 Feb  5  2025 model-00006-of-00012.safetensors
-rwxr-x--- 1 root root 4970415984 Feb  5  2025 model-00007-of-00012.safetensors
-rwxr-x--- 1 root root 4938953008 Feb  5  2025 model-00008-of-00012.safetensors
-rwxr-x--- 1 root root 4970415984 Feb  5  2025 model-00009-of-00012.safetensors
-rwxr-x--- 1 root root 4938953008 Feb  5  2025 model-00010-of-00012.safetensors
-rwxr-x--- 1 root root 4970426312 Feb  5  2025 model-00011-of-00012.safetensors
-rwxr-x--- 1 root root 1557135488 Feb  5  2025 model-00012-of-00012.safetensors
-rwxr-x--- 1 root root      47472 Feb  5  2025 model.safetensors.index.json
-rwxr-x--- 1 root root        613 Feb  5  2025 special_tokens_map.json
-rwxr-x--- 1 root root       7306 Feb  5  2025 tokenizer_config.json
-rwxr-x--- 1 root root   11421896 Feb  5  2025 tokenizer.json
-rwxr-x--- 1 root root    2776833 Feb  5  2025 vocab.json
```


# 删除模型文件夹中所有隐藏文件

天枢模型提供出来后默认可能有很多隐藏文件，统统删除，不然无法启动



# 启动模型


启动命令

```
docker  compose up -d
```

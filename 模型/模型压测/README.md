# 环境安装
```
conda create -n evalscope python=3.10 -y
conda activate evalscope
```
# evalscope安装：
```
pip install 'evalscope[perf]'
```



# 准备数据集
```
cat > benchmark.jsonl <<EOF
{"question":"介绍一下 Kubernetes"}
{"question":"解释 Transformer Attention"}
{"question":"什么是向量数据库"}
EOF
```


# 自定义压测

数据集内容最好是模拟真实生产内容

parallel 设置并发 4 个
-n  设置总共请求量为 100
```
evalscope perf \
  --url http://127.0.0.1:8080/v1/chat/completions \
  --model qwen3.6-27b \
  --dataset openqa   \
  --dataset-path ./benchmark.jsonl  \
  --parallel 4 \
  -n 100 \
  --max-tokens 512 \
```

# 随机压测
更合理
```
evalscope perf \
 --url http://127.0.0.1:8080/v1/chat/completions \
 --model qwen3.6-27b \
 --api openai \
 --dataset random \
 --tokenizer-path /models/Qwen3.6_27B \
 --parallel  32 \
 -n 500 \
 --max-prompt-length 1024 \
 --max-tokens 512
```

# 查看结果
执行完后会输出类似如下的两条内容
performance_summary.txt  是概览
perf_report.html         是报告
2026-05-21 19:40:02 - evalscope - INFO: Performance summary saved to: outputs/20260521_193654/qwen3.6-27b/performance_summary.txt
2026-05-21 19:40:02 - evalscope - INFO: HTML report generated: /models/outputs/20260521_193654/qwen3.6-27b/perf_report.html

如果出现
The system seems not to have reached its performance bottleneck, try higher concurrency
说明还没压满

建议测试：
--parallel 8
然后：
--parallel 16
然后：
--parallel 32

观察：
TPS   token/s  32并发以后基本不涨 说明：GPU打满了   真实吞吐：≈1100 tok/s

|并发|TPS|
|:--|--:|
|4	|  277|
|8	|  510|
|16 |  860|
|32 |  1100|
|64 |  1120|



# 重要参数说明
|参数|说明|
|:--|--:|
|TTFT|首Token时间|
|Gen toks/s|每秒生成 token 数|
|RPS|每秒处理请求数|
|Success Rate|非 100%说明有超时或OOM|
|P99|99% 的请求都不超过这个值，只有最慢的 1% 请求超过这个值|
|Latency (s)|请求延时|
|ITL (ms)|相邻两个Token之间的间隔时间，逐Token统计|
|TPOT (ms)|平均每个输出Token耗时，与ITL接近。整次请求统计|
|Input Tokens|Prompt输入长度统计|
|Output Tokens|输入长度统计|
|Output (tok/s)|输出速度,只统计生成Token速度。公式：输出token数➗生成时间|
|Total (tok/s)|总吞吐速度|
|Decode (tok/s)|解码速度,GPU真正生成Token的速度,通常最重要|
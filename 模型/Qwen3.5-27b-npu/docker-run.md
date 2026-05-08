如果不是自己安装的容器，很可能 docker 版本很老，
不能使用 docker-compose 的话可以使用 docker run 的方式

```
docker run -itd \
  --name tianshu-std-cat \
  --restart always \
  --privileged \
  --ipc=host \
  --pid=host \
  -w /models \
  -p 28080:28080 \
  --log-driver json-file \
  --log-opt max-size=100m \
  --log-opt max-file=3 \
  -e MINDIE_LOG_TO_STDOUT=1 \
  --device /dev/davinci0:/dev/davinci0 \
  --device /dev/davinci1:/dev/davinci1 \
  --device /dev/davinci2:/dev/davinci2 \
  --device /dev/davinci3:/dev/davinci3 \
  --device /dev/davinci4:/dev/davinci4 \
  --device /dev/davinci5:/dev/davinci5 \
  --device /dev/davinci6:/dev/davinci6 \
  --device /dev/davinci7:/dev/davinci7 \
  --device /dev/davinci_manager:/dev/davinci_manager \
  --device /dev/devmm_svm:/dev/devmm_svm \
  --device /dev/hisi_hdc:/dev/hisi_hdc \
  -v /usr/local/dcmi:/usr/local/dcmi \
  -v /usr/local/bin/npu-smi:/usr/local/bin/npu-smi \
  -v /usr/local/Ascend/driver:/usr/local/Ascend/driver \
  -v /etc/ascend_install.info:/etc/ascend_install.info \
  -v /etc/vnpu.cfg:/etc/vnpu.cfg \
  -v /data/tianshu/models:/models \
  quay.io/ascend/vllm-ascend:v0.18.0rc1 tail -f /dev/null > /dev/null \
  vllm serve /models/tianshu-14b-std-cat-gptq-int4-v3-0126 \
    --host 0.0.0.0 \
    --port 28080 \
    --dtype bfloat16 \
    --tensor-parallel-size 1 \
    --max-model-len 4096 \
    --served-model-name tianshu-std-cat \
    --trust-remote-code \
    --uvicorn-log-level info \
    --gpu-memory-utilization 0.4
```
# 目录结构
所有训练好的模型都在
train/bert/train  路径下

适配 npu 过程我们只需要更改 bert.py 即可
# 验证方式
```
 curl -i -k  -H "Content-type: application/json" -X POST -d '{
  "type": "bert", 
  "txt":"伊米仕 vivo X9钢化膜 前后彩膜屏幕保护膜 适用于 步步高vivo X9 5.5英寸 李白凤求凰", 
  "mode_name": "bert_740253157469241344_all"
}'  http://127.0.0.1:9000/recognition/slm_modal/predict_txt

```

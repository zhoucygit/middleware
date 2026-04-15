# 验证方式
 curl -i -k  -H "Content-type: application/json" -X POST -d '{
  "type": "bert", 
  "txt":"伊米仕 vivo X9钢化膜 前后彩膜屏幕保护膜 适用于 步步高vivo X9 5.5英寸 李白凤求凰", 
  "mode_name": "bert_740253157469241344_all"
}'  http://127.0.0.1:9000/recognition/slm_modal/predict_txt
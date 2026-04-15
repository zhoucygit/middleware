# 镜像地址
quay.io/ascend/vllm-ascend
910b4对应的是a2 的镜像如果没有明显写a2 用没有明确说明版本的镜像
本次用的是 
quay.io/ascend/vllm-ascend:v0.18.0rc1

# 部署
本次部署通过 compose部署，制定了卡号，指定了最大 token 大小

# 接口文档
- 说明
Qwen3.5 默认会在响应前进行思考。
您可以通过配置 API 参数，让模型直接返回响应而不进行思考。  以下给出的案例中都禁用了 thinking 功能
想要开启thinking的话传入 true  ："chat_template_kwargs": {"enable_thinking": true},



纯文本举例
curl http://172.16.95.4:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3.5-27b",
	"chat_template_kwargs": {"enable_thinking": false},
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": " 你好呀,能介绍一下美国吗"
          }
        ]
      }
    ]
  }'	

视频输入举例：
curl http://172.16.95.4:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3.5-27b",
	"chat_template_kwargs": {"enable_thinking": false},
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "video_url",
            "video_url": {
              "url": "http://172.16.95.4/test.mp4"
            }
          },
          {
            "type": "text",
            "text": "视频中主要讲了什么"
          }
        ]
      }
    ]
  }'
	
	
图片输入举例：
curl http://172.16.95.4:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3.5-27b",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "image_url",
            "image_url": {
              "url": "http://172.16.95.4/test.jpg"
            }
          },
          {
            "type": "text",
            "text": " 图片中都有什么图形，不用给我显示分析过程，即图片关系，直接告诉我结果即可"
          }
        ]
      }
    ]
  }'
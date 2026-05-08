import json
import requests
from datetime import datetime

INPUT_JSON = "questions.json"
OUTPUT_FILE = "result.txt"

API_URL = "http://192.168.99.38:8206/v1/chat/completions"
MODEL_NAME = "qwen3-32b-ChinaCoal"

headers = {
    "Content-Type": "application/json"
}

# 读取题库
with open(INPUT_JSON, "r", encoding="utf-8") as f:
    questions = json.load(f)

with open(OUTPUT_FILE, "w", encoding="utf-8") as out:

    out.write(f"测试时间: {datetime.now()}\n")
    out.write("=" * 80 + "\n\n")

    for item in questions:

        qid = item.get("id")
        category = item.get("category")
        prompt = item.get("prompt")

        print(f"正在测试: {qid}")

        payload = {
            "stop": "<|im_end|>",
            "max_tokens": 512,
            "temperature": 0.1,
            "messages": [
                {
                    "role": "user",
                    "content": prompt
                }
            ],
            "model": MODEL_NAME,
            "chat_template_kwargs": {
                "enable_thinking": False
            }
        }

        try:
            response = requests.post(
                API_URL,
                headers=headers,
                json=payload,
                timeout=300
            )

            response.raise_for_status()

            result = response.json()

            answer = (
                result.get("choices", [{}])[0]
                .get("message", {})
                .get("content", "")
            )

        except Exception as e:
            answer = f"ERROR: {str(e)}"

        out.write("=" * 80 + "\n")
        out.write(f"ID: {qid}\n")
        out.write(f"CATEGORY: {category}\n")
        out.write("QUESTION:\n")
        out.write(f"{prompt}\n\n")
        out.write("ANSWER:\n")
        out.write(f"{answer}\n\n")

print(f"\n测试完成，结果已保存到: {OUTPUT_FILE}")
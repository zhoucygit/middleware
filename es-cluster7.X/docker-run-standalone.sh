#!/bin/bash
# 8.X 版本部署
docker run -itd --name elasticsearch \
--shm-size=1g \
--privileged=true -m 4GB \
-p 9200:9200  \
-p 9300:9300 \
-v ./ES_DATA:/usr/share/elasticsearch/data  \
-v /etc/localtime:/etc/localtime:ro \
-e ELASTIC_PASSWORD="010.Tydic"  \
-e TZ="Asia/Shanghai" \
-e discovery.type="single-node" \
-e "ES_JAVA_OPTS=-Xms2G -Xmx2G" \
elasticsearch:8.10.4



#7.X版本部署
docker run -itd \
--name elasticsearch \
--shm-size=1g \
--privileged=true \
--restart always  \
-p 9200:9200 \
-p 9300:9300 \
-v ./ES_DATA:/usr/share/elasticsearch/data \
-v /etc/localtime:/etc/localtime:ro \
-e TZ="Asia/Shanghai" \
-e "discovery.type=single-node"  \
-e "ES_JAVA_OPTS=-Xms2G -Xmx2G" \
docker.elastic.co/elasticsearch/elasticsearch:7.17.21
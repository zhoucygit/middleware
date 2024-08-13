#!/bin/bash
# 8.X 版本部署
docker run -itd --name elasticsearch \
--shm-size=512mb \
--privileged=true -m 4GB \
--restart always  \
-p 9200:9200  \
-p 9300:9300 \
-v ./ES_DATA:/usr/share/elasticsearch/data  \
-v ./ES-plugins:/usr/share/elasticsearch/plugins \
-v /etc/localtime:/etc/localtime:ro \
-e ELASTIC_PASSWORD="010.Tydic"  \
-e TZ="Asia/Shanghai" \
-e discovery.type="single-node" \
-e "ES_JAVA_OPTS=-Xms2G -Xmx2G" \
elasticsearch:8.10.4



#7.X版本部署
docker run -itd \
--name elasticsearch \
--shm-size=512mb \
--privileged=true \
--restart always  \
-p 9200:9200 \
-p 9300:9300 \
-v ./ES_DATA:/usr/share/elasticsearch/data \
-v ./ES-plugins:/usr/share/elasticsearch/plugins \
-v /etc/localtime:/etc/localtime:ro \
-e TZ="Asia/Shanghai" \
-e "discovery.type=single-node"  \
-e "ES_JAVA_OPTS=-Xms2G -Xmx2G" \
docker.elastic.co/elasticsearch/elasticsearch:7.17.21




docker run -d --name kibana -e ELASTICSEARCH\_HOSTS=http://elasticsearch:9200 --network=es-net -p 5601:5601 kibana:7.12.1
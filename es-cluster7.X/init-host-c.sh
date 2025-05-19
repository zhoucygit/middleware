#!/bin/bash
#将以下参数更改为本机实际信息
umask 0022
HOSTIP1=192.168.10.129
HOSTIP2=192.168.10.130
HOSTIP3=192.168.10.131
HTTPPORT=9200
TRANSPORT=9300


#以下部分不要改动
NODENAME=elasticsearch-3
mkdir -p conf
rm -rf conf/elasticsearch.yml
rm -rf docker-compose.yaml
cp templats/elasticsearch.yml.temp conf/elasticsearch.yml
cp templats/docker-compose.yaml.temp docker-compose.yaml

sed -i "\
s#HOSTIP1#${HOSTIP1}#g;\
s#HOSTIP2#${HOSTIP2}#g;\
s#HOSTIP3#${HOSTIP3}#g;\
s#HTTPPORT#${HTTPPORT}#g;\
s#TRANSPORT#${TRANSPORT}#g;\
s#NODENAME#${HOSTIP3}#g;\
" conf/elasticsearch.yml

sed -i "s#NODENAME#${NODENAME}#g;
s#HTTPPORT#${HTTPPORT}#g;\
s#TRANSPORT#${TRANSPORT}#g;\
" docker-compose.yaml

mkdir -p  ./ES_DATA
mkdir -p  ./ES_LOG
mkdir -p  ./ES_PLUGINS

chmod 777 -R  ./ES_DATA
chmod 777 -R  ./ES_LOG
chmod 777 -R  ./ES_PLUGINS
docker compose -f docker-compose.yaml up -d
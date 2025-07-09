#!/bin/bash
#只需要修改该host地址
HOST=192.168.10.129

#以下内容不用修改
REDISPORT=7002
REDISBUSPORT=17002

mkdir -p conf
\cp template/redis.conf conf/redis-${REDISPORT}.conf
\cp template/docker-compose.yaml docker-compose-${REDISPORT}.yaml
sed -i "s#REDISPORT#${REDISPORT}#g;s#REDISBUSPORT#${REDISBUSPORT}#g;s#HOST#${HOST}#g"  conf/redis-${REDISPORT}.conf docker-compose-${REDISPORT}.yaml
docker  compose -f docker-compose-${REDISPORT}.yaml up -d
#!/bin/bash
#只需要修改该host地址
REDIS_MASTER=192.168.10.129
REDIS_PASSWORD="HyhTu1Q_sZfL7"


mkdir -p conf
rm -rf conf/redis.conf
rm -rf conf/sentinel.conf
cp template/redis.conf conf/redis.conf
cp template/sentinel.conf conf/sentinel.conf

sed -i "\
s#REDIS_PASSWORD#${REDIS_PASSWORD}#g;\
s#replicaof#replicaof ${REDIS_MASTER} 6379#g"  conf/redis.conf 

sed -i "\
s#REDIS_PASSWORD#${REDIS_PASSWORD}#g;\
s#REDIS_MASTER#${REDIS_MASTER}#g"  conf/sentinel.conf

docker  compose  up -d
#!/bin/bash
#将ip地址更换为本机ip地址
BROKERIP1=192.168.10.129
rm -rf conf/broker.conf
cp conf/broker.conf.temp conf/broker.conf
sed -i "s#BROKERIP1#${BROKERIP1}#g" conf/broker.conf
mkdir -p ./data/broker/logs
mkdir -p ./data/broker/data
mkdir -p ./data/nameserver/logs
chmod 777 -R ./data
docker compose -f docker-compose-a.yaml up -d
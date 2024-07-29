#!/bin/bash
#将ip地址更换为本机ip地址
umask 0022
HOSTIP1=192.168.10.129
HOSTIP2=192.168.10.130




mkdir -p conf
rm -rf conf/broker-a.conf
rm -rf conf/broker-b.conf
cp templats/broker.conf.temp conf/broker-a.conf
cp templats/broker.conf.temp conf/broker-b.conf

sed -i "\
s#NAMESERVERIP1#${HOSTIP1}#g;\
s#NAMESERVERIP2#${HOSTIP2}#g;\
s#BROKERIP1#${HOSTIP2}#g;\
s#BROKERIP2#${HOSTIP2}#g;\
s#BROKERNAME#broker-a#g;\
s#BROKERID#1#g;\
s#BROKERLISENPORT#10911#g;\
s#FASTLISTENPORT#10909#g;\
s#HALISTENPORT#10912#g;\
s#BROKERROLE#SLAVE#g;\
" conf/broker-a.conf


sed -i "\
s#NAMESERVERIP1#${HOSTIP1}#g;\
s#NAMESERVERIP2#${HOSTIP2}#g;\
s#BROKERIP1#${HOSTIP2}#g;\
s#BROKERIP2#${HOSTIP2}#g;\
s#BROKERNAME#broker-b#g;\
s#BROKERID#0#g;\
s#BROKERLISENPORT#10921#g;\
s#FASTLISTENPORT#10919#g;\
s#HALISTENPORT#10922#g;\
s#BROKERROLE#ASYNC_MASTER#g;\
" conf/broker-b.conf


mkdir -p ./data/broker/logs-a
mkdir -p ./data/broker/logs-b
mkdir -p ./data/broker/data-a
mkdir -p ./data/broker/data-b
mkdir -p ./data/nameserver/logs
chmod 777 -R ./data
docker compose -f docker-compose.yaml up -d
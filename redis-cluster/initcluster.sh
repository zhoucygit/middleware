#!/bin/bash
host1=192.168.10.210
host2=192.168.10.230
host3=192.168.10.213
redisport1=7001
redisport2=7002
docker exec -it redis-7001 redis-${redisport1} --cluster create ${host1}:${redisport1} ${host2}:${redisport1} ${host3}:${redisport1} ${host1}:${redisport2} ${host2}:${redisport2} ${host3}:${redisport2} --cluster-replicas 1 -a Redis235
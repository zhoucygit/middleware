#!/bin/bash
host1=192.168.10.210
host2=192.168.10.230
host3=192.168.10.213
redis-cli --cluster create ${host1}:7001 ${host2}:7001 ${host3}:7001 ${host1}:7002 ${host2}:7002 ${host3}:7002 --cluster-replicas 1
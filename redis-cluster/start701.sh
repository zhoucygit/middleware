REDISPORT=7001

cp template/redis.conf conf/redis-${REDISPORT}.conf
cp template/docker-compose.yaml docker-compose-${REDISPORT}.yaml
sed -i "s#REDISPORT#${REDISPORT}#g"  redis-${REDISPORT}.conf
mkdir /data_${REDISPORT}
chmod 777 /data_${REDISPORT}

docker  compose -f docker-compose-${REDISPORT}.yaml up -d
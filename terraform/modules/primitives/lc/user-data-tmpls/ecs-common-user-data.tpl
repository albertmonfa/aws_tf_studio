#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo Begin: user-data

echo Begin: start ECS
echo ECS_CLUSTER=${cluster_name} >> /etc/ecs/ecs.config
start ecs
until $(curl --output /dev/null --silent --head --fail http://localhost:51678/v1/metadata); do
  printf '.'
  sleep 1
done
echo End: start ECS

echo Begin: Bootstraping EC2
yum install -y epel-release yum-utils
yum-config-manager --enable epel
yum install -y yum-python26 wget s3cmd ansible
# SOME PAYLOAD
echo End: Bootstraping EC2

echo End: user-data

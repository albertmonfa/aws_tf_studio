#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo Begin: user-data

echo Begin: Bootstraping EC2
yum install -y epel-release yum-utils
yum-config-manager --enable epel
yum install -y yum-python26 wget s3cmd ansible
# SOME PAYLOAD
echo End: Bootstraping EC2

echo End: user-data

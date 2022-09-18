#!/bin/bash

cp env.template env

echo 'export HADOOP_VERSION=2.7.0' >> env
echo 'export HIVE_VERSION=1.2.0' >> env

docker pull  --platform=linux/arm64 jerry9916/centos-box:latest
docker build --platform=linux/arm64 -t jerry9916/hadoop-hive:arm64_v1 .

docker pull  --platform=linux/amd64 jerry9916/centos-box:latest
docker build --platform=linux/amd64 -t jerry9916/hadoop-hive:amd64_v1 .
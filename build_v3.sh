#!/bin/bash

cp env.template env

echo 'export HADOOP_VERSION=3.3.1' >> env
echo 'export HIVE_VERSION=3.1.2' >> env

docker pull  --platform=linux/arm64 jerry9916/centos-box:latest
docker build --platform=linux/arm64 -t jerry9916/hadoop-hive:arm64_v3 .

docker pull  --platform=linux/amd64 jerry9916/centos-box:latest
docker build --platform=linux/amd64 -t jerry9916/hadoop-hive:amd64_v3 .
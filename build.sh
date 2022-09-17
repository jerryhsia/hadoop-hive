#!/bin/bash

docker pull  --platform=linux/arm64 jerry9916/centos-box:latest
docker build --platform=linux/arm64 -t jerry9916/hadoop-hive:arm64_v2 .
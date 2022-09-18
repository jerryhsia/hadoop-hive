# hadoop-hive

| TAG | HADOOP VERSION | HIVE VERSION |
| ---- | ---- | ---- |
| arm64_v0/amd64_v0 | 2.7.0 | 0.14.0 |
| arm64_v1/amd64_v1 | 2.7.0 | 1.2.0 |
| arm64_v2/amd64_v2 | 2.7.0 | 2.1.0 |
| arm64_v3/amd64_v3 | 3.3.1 | 3.1.2 |

```bash
docker run -itd --name hive3 --privileged=true \
     -p 8714:8088 \
     -p 8722:8020 \
     -p 8770:9870 \
     -p 8719:10000 \
     -p 8712:10002 \
     -v /etc/localtime:/etc/localtime \
     jerry9916/hadoop-hive:arm64_v3 /usr/sbin/init

# 进入容器
docker exec -it hive3 bash

# 启动服务
/root/startup.sh
```
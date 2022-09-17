# hadoop3-hive

```bash
docker run -itd \
     -p 8714:8088 \
     -p 8722:8020 \
     -p 8770:9870 \
     -p 8719:10000 \
     -p 8712:10002 \
     -v /etc/localtime:/etc/localtime
     --name hive3 --privileged jerry9916/hadoop3-hive3:latest /usr/sbin/init

# 进入容器
docker exec -it hive3 bash

# 启动服务
/root/startup.sh
```
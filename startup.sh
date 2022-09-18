#!/bin/bash

if [ ! -f "/root/.lock" ]; then
    echo "start init......."
    sleep 10s
    mysqladmin password root
    if [ "$?" = "0" ]; then
        schematool -initSchema -dbType mysql
    else
        exit 1
    fi

    echo "Y" | hadoop namenode -format
    echo "Y" | hadoop datanode -format
    touch /root/.lock
fi

arr=(`jps|grep -v Jps|awk '{print $1}'|tr "\n" " "`) && for element in ${arr[@]}; do echo -e "pid:\e[31m $element \e[0mhas been killed. -\e[32m `date "+%Y-%m-%d %H:%M:%S"`\e[0m";kill -9 $element; done
echo -e "\e[32mAll Jps processes were killed\e[0m"

start-all.sh
echo -e "\e[32mHadoop started\e[0m"
hdfs dfsadmin -report
hdfs dfsadmin -safemode leave
nohup hive --service metastore >> /root/metastore.log 2>&1 &
nohup hive --service hiveserver2 >> /root/hiveserver2.log 2>&1 &

if [ "$?" = "0" ]; then
    echo -e "\e[32mHive started and testing...\e[0m"
    sleep 10s
    if [ ! -f "/root/.locksql" ]; then
        echo "init data..."
        hive -e "source /root/titanic.sql;"

        if [ -f "/opt/hive/examples/files/kv2.txt" ];then
            hive -e "CREATE TABLE invites (foo INT, bar STRING) PARTITIONED BY (ds STRING);"
            hive -e "LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv2.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2022');"
        fi

        touch /root/.locksql
    fi

    hive -e "show tables;"
    echo -e "\e[32mEverything seems OK!\e[0m"
else
    echo -e "\e[31mOops.Something wrongs!\e[0m" 1>&2
    exit 1
fi
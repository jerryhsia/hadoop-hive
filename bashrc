export HIVE_HOME=/opt/hive
export HADOOP_HOME=/opt/hadoop
export JAVA_HOME=/opt/java
export JSVC_HOME=/opt/commons-daemon-1.3.1-src/src/native/unix
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$PATH

export HDFS_DATANODE_USER=root
export HDFS_DATANODE_SECURE_USER=root
export HDFS_NAMENODE_USER=root
export HDFS_SECONDARYNAMENODE_USER=root
export YARN_RESOURCEMANAGER_USER=root
export YARN_NODEMANAGER_USER=root
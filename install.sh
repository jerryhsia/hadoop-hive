#!/bin/bash

cd /tmp

cat /tmp/bashrc >> /root/.zshrc
cat /tmp/bashrc >> /root/.bashrc

prepare() {

	grep 'AltArch' /etc/os-release
	if [ "$?" = "0" ];then
		#arm64
		echo "os: arm64"
	else
		#amd64
		echo "os: amd64"
	fi
	sleep 3

	yum install -y wget net-tools lsof strace vim
}

install_java() {
	cd /tmp

	grep 'AltArch' /etc/os-release
	if [ "$?" = "0" ];then
		wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/jdk-8u202-linux-arm64-vfp-hflt.tar.gz
		tar -xf jdk-8u202-linux-arm64-vfp-hflt.tar.gz -C /opt
	else
		wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/jdk-8u202-linux-x64.tar.gz
		tar -xf jdk-8u202-linux-x64.tar.gz -C /opt
	fi
	ln -s /opt/jdk1.8.0_202 /opt/java
}

install_mysql() {
	cd /tmp

	yum install -y mariadb mariadb-server
	systemctl enable mariadb.service
}

install_ssh() {
	cd /tmp

	yum install -y openssh openssh-clients openssh-server
	echo "" | ssh-keygen -t rsa -N ""
	cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
	systemctl enable sshd
}

install_jsvc() {
	cd /tmp

	wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/commons-daemon-1.3.1-src.tar.gz
	tar -xf commons-daemon-1.3.1-src.tar.gz -C /opt
	yum install -y gcc-c++ make
	cd /opt/commons-daemon-1.3.1-src/src/native/unix
	./configure --with-java=/opt/java
	make
}

install_hadoop() {
	cd /tmp

	grep 'AltArch' /etc/os-release
	if [ "$?" = "0" ];then
		#arm64
		echo "os: arm64"

		wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/hadoop-3.3.1-aarch64.tar.gz
		tar -xf hadoop-3.3.1-aarch64.tar.gz -C /opt
		
	else
		#amd64
		echo "os: amd64"

		wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/hadoop-3.3.1.tar.gz
		tar -xf hadoop-3.3.1.tar.gz -C /opt
		
	fi
	sleep 3
	ln -s /opt/hadoop-3.3.1 /opt/hadoop

	cp core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml /opt/hadoop/etc/hadoop/
}

install_hive() {
	cd /tmp

	wget --no-check-certificate https://ai-platform-package.gz.bcebos.com/bigdata/apache-hive-3.1.2-bin.tar.gz
	tar -xf apache-hive-3.1.2-bin.tar.gz -C /opt
	ln -s /opt/apache-hive-3.1.2-bin /opt/hive

	cp hive-site.xml /opt/hive/conf
	cp mysql-connector-java-5.1.47.jar /opt/hive/lib
}

clean() {
	yum clean all
	rm -rf /tmp/*
}

prepare
install_java
install_ssh
install_mysql
install_jsvc
install_hadoop
install_hive
clean
FROM jerry9916/centos-box:latest

USER root
WORKDIR /root

COPY startup.sh titanic.sql /root/

COPY lib/* conf/*.xml install.sh bashrc /tmp
# COPY tmp/* /tmp

RUN /tmp/install.sh && rm -rf /tmp/install.sh 2>&1

ENTRYPOINT ["/usr/sbin/init"]
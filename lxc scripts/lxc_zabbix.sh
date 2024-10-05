#! /bin/bash
#Basic configuration
CTID=300
NAME=Wordpress
MEMORY=1024
CORES=1
STORAGE=vm-pool
GB=30
PASSWORD=Ubuntu

#networking
NETINT=eth0
BRIDGE=vmbr0
FIREWALL=1
GW=10.24.27.1
IP=10.24.27.20/24
RATE=50
DNS=1.1.1.1


pct create $CTID \
files-storage:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
--hostname $NAME \
--memory $MEMORY \
--cores $CORES \
--storage $STORAGE \
--rootfs $STORAGE:$GB \
--net0 name=$NETINT,bridge=$BRIDGE,firewall=$FIREWALL,gw=$GW,ip=$IP,type=veth,rate=$RATE \
--nameserver $DNS \
--password $PASSWORD

pct start $CTID

pct push 300 /root/scripts/zabbix.sh /root/zabbix.sh
pct exec 300 chmod u+x /root/zabbix.sh
pct exec 300 ./root/zabbix.sh
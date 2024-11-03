#! /bin/bash
#Basic configuration
CTID=500
NAME=Docker
MEMORY=1024
CORES=1
STORAGE=vm-pool
GB=20
PASSWORD=Ubuntu

#networking
NETINT=eth0
BRIDGE=vmbr0
FIREWALL=1
GW=10.24.27.1
IP=10.24.27.41/24
DNS=1.1.1.1


pct create $CTID \
files-storage:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
--hostname $NAME \
--memory $MEMORY \
--cores $CORES \
--storage $STORAGE \
--rootfs $STORAGE:$GB \
--net0 name=$NETINT,bridge=$BRIDGE,firewall=$FIREWALL,gw=$GW,ip=$IP,type=veth \
--nameserver $DNS \
--unprivileged 1 \
--features keyctl=1,nesting=1 \
--password $PASSWORD \

pct start $CTID

pct exec $CTID -- bash -c 'sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config'
pct exec $CTID -- bash -c 'systemctl restart ssh'
pct exec $CTID -- bash -c 'apt update'
pct exec $CTID -- bash -c 'apt install docker.io docker-compose -y'
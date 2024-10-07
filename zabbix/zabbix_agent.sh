#! /bin/bash
IP=$(hostname -I)
HOSTNAME=$(hostname)
SERVER=10.24.27.14
META=wordpress

echo "============================================" 
echo "install zabbix agent" 
echo "============================================"

wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-2+ubuntu22.04_all.deb
apt update

apt install zabbix-agent -y
systemctl restart zabbix-agent
systemctl enable zabbix-agent

sleep 20

sed -i "s/Server=127.0.0.1/Server=$SERVER/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=$SERVER/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix server/Hostname=$HOSTNAME/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/# HostMetadata=/HostMetadata=$META/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/# HostInterface=/HostInterface=$IP/" /etc/zabbix/zabbix_agentd.conf

ufw allow 10050
systemctl restart zabbix-agent

echo "============================================" 
echo "Finish install zabbix agent" 
echo "============================================"



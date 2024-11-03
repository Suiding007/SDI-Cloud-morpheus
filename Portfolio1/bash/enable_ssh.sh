#! /bin/bash

echo "============================================" 
echo "enable ssh" 
echo "============================================"
echo

sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
systemctl restart ssh              


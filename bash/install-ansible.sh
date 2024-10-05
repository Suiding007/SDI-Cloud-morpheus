#! /bin/bash
echo "============================================" 
echo "install ansible" 
echo "============================================" 

sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

echo
echo "============================================" 
echo "create playbook" 
echo "============================================" 

sudo mkdir /etc/ansible/playbooks
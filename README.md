# proxansi-morpheus
before you start creating and maintaining virtual machines and containers within proxmox, by using ansible scripts. you need first to install certain dependencies.
It is important to know, that the ansible master need to have a connection with the proxmox server.

## Install ansible
get the latest version of ansible
```
sudo add-apt-repository ppa:ansible/ansible 
```
install ansible packages
```
sudo apt install ansible
```

## Install ansible dependencies
firstly install de python libary proxmoxer
```
pip install proxmoxer
```
if certain modules not existend, then use the follow command to install all modules that can been used with proxmox
```
ansible-galaxy collection install community.general
```

### docs links
ansible documentation [proxmox_kvm](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_kvm_module.html)


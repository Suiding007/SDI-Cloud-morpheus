# proxansi-morpheus
before you start creating and maintaining virtual machines and containers in proxmox by using ansible scripts. You need first to install dependencies.
It is important to know, that the ansible master need to have a connection with the proxmox server.


### Install ansible dependencies
firstly install de python libary proxmoxer
```
pip install proxmoxer
```
if certain modules not existend, then use the follow command to install all modules that can been used
```
ansible-galaxy collection install community.general
```

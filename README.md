# SDN-Cloud-morpheus
Before you start creating and maintaining virtual machines and containers within proxmox, by using ansible scripts. you need first to install certain dependencies.
It is important to know, that the ansible master need to have a connection with the proxmox server by over ssh.

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
#Proxmox commands
```
#updating lxc container list
pveam update

#shows available lxc containers templates
pveam available 

#download container template
pveam download local(location for iso and ct templates) [container name] 

#list download lxc templates
pveam list local 


```



### docs links
ansible documentation [proxmox_kvm](https://docs.ansible.com/ansible/latest/collections/community/general/proxmox_kvm_module.html)
* https://pve.proxmox.com/pve-docs/qm.1.html
* https://pve.proxmox.com/pve-docs/pct.1.html
* https://pve.proxmox.com/wiki/Linux_Container
* https://noted.lol/building-a-lxc-in-proxmox-with-automation/
* https://www.shellhacks.com/mysql-run-query-bash-script-linux-command-line/
* https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/
* https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/
* https://www.youtube.com/watch?v=PNCF4QFItSo
* https://www.youtube.com/watch?v=h8qEXBp--WU 



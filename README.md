# SDI2425-437407
# Proxmox commands
```
# updating lxc container list
pveam update

# shows available lxc containers templates
pveam available 

# download container template
pveam download local(location for iso and ct templates) [container name] 

# list download lxc templates
pveam list local

create a snapshot into cephfs system: vzdump [VID] --storage cephfs --compress zstd
```

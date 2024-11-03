#! /bin/bash
wget -q https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img     
qemu-img resize jammy-server-cloudimg-amd64.img 32G
export CUSTOM_USER_NAME=ubuntu
export CUSTOM_USER_PASSWORD=Ubuntu

qm create 1000 --name "ubuntu-2404-cloudinit-template" --ostype l26 \
    --memory 2048 \
    --agent 1 \
    --bios ovmf --machine q35 --efidisk0 vm-pool:0,pre-enrolled-keys=0 \
    --cpu host --socket 1 --cores 1 \
    --vga serial0 --serial0 socket  \
    --net0 virtio,bridge=vmbr0


qm importdisk 1000 jammy-server-cloudimg-amd64.img vm-pool
qm set 1000 --scsihw virtio-scsi-pci --virtio0 vm-pool:vm-1000-disk-1,discard=on

qm set 1000 --boot order=virtio0
qm set 1000 --ide2 vm-pool:cloudinit

cat << EOF | tee /mnt/pve/files-storage/snippets/vendor.yaml
#cloud-config
runcmd:
    - apt update
    - apt install -y qemu-guest-agent
    - systemctl start qemu-guest-agent
    - reboot
EOF



qm set 1000 --cicustom "vendor=files-storage:snippets/vendor.yaml"
qm set 1000 --tags ubuntu-template,24.04,cloudinit
qm set 1000 --ciuser ubuntu --ciupgrade 1
qm set 1000 --cipassword $(openssl passwd -6 $CUSTOM_USER_PASSWORD)
qm set 1000 --sshkeys ~/.ssh/authorized_keys
qm set 1000 --ipconfig0 ip=dhcp
qm cloudinit update 1000
qm template 1000


qm clone 1000 201 --name espocrm1 -full -storage vm-pool
qm set 201 --ipconfig0 ip=10.24.27.32/24,gw=10.24.27.1
qm set 201 --nameserver 1.1.1.1
qm set 201 --core 2 --memory 2048 --balloon 0
qm resize 201 virtio0 +18G
qm start 201

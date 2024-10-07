#! /bin/bash
qm clone 1000 201 --name espocrm1 -full -storage vm-pool
qm set 201 --ipconfig0 ip=10.24.27.32/24,gw=10.24.27.1
qm set 201 --nameserver 1.1.1.1
qm set 201 --core 2 --memory 2048 --balloon 0
qm start 201
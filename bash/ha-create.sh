#! /bin/bash 
ha-manager groupadd HaProtect -nodes "pve1270,pve1271,pve1272" -restricted -nofailback
ha-manager add <VID>
ha-manager set <VID> --state stopped
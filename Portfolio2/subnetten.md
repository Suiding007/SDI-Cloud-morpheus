## subnetten
Subnetten zijn een beangrijk onderdeel om netwerken van elkaar af te scheiden. 
gebruikers binnen een subnet kunnen dan niet communiceren met gebruikers van uit een andere subnet, 
tenzij een netwerk beheerde het zo configuur dat deze wel met elkaar kan communiceren. 

Om meer subnetten aan te maken in een docker-compose is het mogelijk om een nieuwe netwerk bridge aan te maken

```yaml
networks:
  net1:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.100.0/24
    
    net2:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.200.0/24
```
<br>
Het is ook mogelijk om meerdere subnetten te maken binnen 1 netwerk

```yaml
networks:
  net1:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.100.0/24
          gateway: 192.168.100.1
        - subnet: 192.168.100.0/24
          gateway: 192.168.100.1
```

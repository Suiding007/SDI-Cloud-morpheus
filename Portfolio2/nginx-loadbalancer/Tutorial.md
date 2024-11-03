# tutorial Nginx load-balancer
## Loadbalancers
Mensen willen graag een prettige browser ervaring hebben op het web. mensen willen
snel hun favoriete webpage kunnen lezen, zonder dat deze enige vorm van
load issues bevat of niet bereikbaar is.

Om deze problemathiek te voorkomen zijn er loadbalancers. In deze tutorial wordt er een 
gekozen tutorial over nginx loadbalancer omschrijven en komt er een verbeterde versie 
geschreven door CHATGPT voor die de loadbalancer dynamisch en scalable maakt.

## creating files
Voor deze tutorial maken we gebruik van de artikel/tutorial van de website dev.to. je kan deze artikel 
vinden in de paragraaf [Docs](#Docs)

We beginnen deze tutorial met het aanmaken van een set aan files en directories. Deze files bieden de mogelijkheid
om een loadbalancer aan te maken en te configuren. In de schema hier beneden kan je
de mappen structuur die word gehandeerd vinden. Belangrijk is dat de website een copy van elkaar zijn. Dit is belangrijk omdat de gebruiker
niet opeens op een totale andere website pagina terecht komen als ze de website refreshen.

```
Nginx-loadbalancer
│
├── app1
│   ├── app1.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── app2
│   ├── app2.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── nginx
│   ├── nginx.conf
│   └── Dockerfile
│
└── docker-compose.yaml
```

### ---------------App1 directory-----------------
In de app1 direcotory, maken we files aan die moet dienen als een website.
Hiervoor is Flask gebruikt. Flask is een web framework die verzorgd dat 
de routering en web acties goed werken.

In app1.py maken we via Flask de website aan, waarmee we kunnen bekijken of de Nginx loadbalancer
switch van webservers om de load te verdelen.

**app1.py**
```py
from flask import request, Flask
import socket

app1 = Flask(__name__)

@app1.route('/')
def hello_world():
    return '<h1>Hello from server 1</h2>'


if __name__ == '__main__':
   app1.run(debug=True, host='0.0.0.0')
```
<br>
In de requirements.txt file wordt de dependecies die Flask nodig heeft opgenomen.

**requirements.txt**
```
Flask==3.0.3
Werkzeug==3.0.0
```
<br>
Vervolgens wordt er een Dockerfile aangemaakt. Deze file maakt een container images aan
die alles bevat om de website te draaien, denk aan de dependecies, python en de Flask code.

**Dockerfile**
```dockerfile
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT [ "python3" ]
CMD [ "app1.py" ]
```


### ---------------App2 directory-----------------
Net als in de direcotory app1 maken we een Flask website aan waarmee de loadbalancer
tussen moet switchen. bij app2.py veranderen we alleen de return naar "hello form server 1" naar
"hello form server 2" zodat je precies de switching van de loadbalancing kan inzien. 

**app2.py**
```py
from flask import request, Flask
app1 = Flask(__name__)

@app1.route('/')
def hello_world():
    return '<h1>Hello from server 2</h2>'

if __name__ == '__main__':
   app1.run(debug=True, host='0.0.0.0')
```
<br>
Net als bij app1 maken we een requieremets.txt file aan met de dependencies die moeten verzorgen
dat Flask goed kan draaien.

**requirements.txt**
```
Flask==3.0.3
Werkzeug==3.0.0
```
<br>
Ook zijn er weinige aanpassing aan de Dockerfile, het enige verschil met app1 is dat we de website app2.py willen inladen in deze Docker images.

**Dockerfile**
```dockerfile
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT [ "python3" ]
CMD [ "app2.py" ]
```


### ---------------nginx directory-----------------
Nu er 2 vergelijkbare website zijn. gaan we nu de loadbalancer configuratie file aan maken. 
We beginnen met het defineren van een server pool, hierin wordt voor Nginx aangegeven tussen welke
servers de websites geloadbalanced moet worden. met de weging van 5 wordt er aan gegeven dat het gaat om 50% server 1
en 50% server 2. Als je kan merken gaat het bij deze loadbalancer om de round robin methode die moet verzorgen dat de 
load verdeling equally draait tussen deze 2 servers.

Als dat gedefineerd is, moet er alleen nog aangegeven worden dat de loadbalancer de requesten doorgeven via de weblink http://loadbalancer.
oftewel elke keer als iemand de website refreshed, dan wordt de volgende server aangeroepen en door gestuurd naar de host ip adress.



nginx.conf
```conf
upstream loadbalancer {
    server 172.17.0.1:5001 weight=5;
    server 172.17.0.1:5002 weight=5;
}

server {
    location / {
        proxy_pass http://loadbalancer;
    }
}

```
<br>
Net als de websites, wordt ook de Nginx configuratie ingeladen in een docker images. De default config file van Nginx wordt vervangen met
de configuratie file die door ons is gedefineerd. 

**Dockerfile**
```dockerfile
FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

### ---------------Nginx-loadbalancer direcotory-----------------
uit einderlijk worden alle onderdelen in de docker-compose file gedefineerd voor makkelijke deployement van alle containers.

**docker-compose.yaml**
```yaml
version: '3'
services:
  app1:
    build: ./app1
    ports:
    - "5001:5000"
  app2:
    build: ./app2
    ports:
    - "5002:5000"
  nginx:
    build: ./nginx 
    ports:
    - "8080:80"
    depends_on:
      - app1
      - app2
```
<br>
het enige wat er nog moet gebeuren is om alle images en containers op te bouwen. hiervoor wordt de commando: "docker-compose up -d" voor gebruikt.
Na het opbouwen van alle onderdelen is de geloadbalancerd website te vinden via: "http://ip-machine:8080"

```
sudo docker-compose up -d
```

# Scalable loadbalancer version
In deze gedeelte van de tutorial is een aangepaste en geadvanceerde versie 
van de loadbalancer hierboven. Deze loadbalancer is aangepast door CHATGPT.

De rede voor het gebruiken van CHATGPT om de loadbalancer aan te passen speciaal
voor scaling, is vooral gericht op tijdsbepreking en teveel artikelen over ip van
gebruikers in te zien in plaatst van dynamisch hostname verandering van containers.

## create files
```
Nginx-loadbalancer
│
├── app1
│   ├── app1.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── nginx
│   ├── nginx.conf
│   └── Dockerfile
│
└── docker-compose.yaml
```

### ---------------App1 directory-----------------
In plaats van een static stuk tekst, is er nu een dynamische tekst die via een socket de hostname van de container ophaalt.
Deze wordt op de website afgebeeld zo dat er te zien is tussen welke containers er geloadbalanced wordt.

**app1.py**
```py
from flask import request, Flask
import socket

app1 = Flask(__name__)

@app1.route('/test')
def hello():
    return f"Hello from container {socket.gethostname()}"


if __name__ == '__main__':
   app1.run(debug=True, host='0.0.0.0')
```
<br>
De requirements.txt is het zelfde als de tutorial hierboven.

**requirements.txt**
```
Flask==3.0.3
Werkzeug==3.0.0
```
<br>
Ook de Dockerfile is het zelfde als de tutorial hierboven.

**Dockerfile**
```dockerfile
FROM python:3
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip install -r requirements.txt
COPY . /
ENTRYPOINT [ "python3" ]
CMD [ "app1.py" ]
```

### ---------------nginx directory-----------------
Bij de Nginx.conf wordt alleen aangegeven dat we loadbalance op containers die gebruik maken van de app1 images. 
door alleen specifiek de uitgaande poort te specifieren is het mogelijk voor Nginx om zelf een inside poort te voegen aan elk server.

**nginx.conf**
```conf
upstream loadbalancer {
    server app1:5000;
}

server {
    location / {
        proxy_pass http://loadbalancer;
    }
}
```
<br>
De Nginx Dockerfile is het zelfde als de Dockerfile die is gebruikt in de tutorial hierboven.

**Dockerfile**
```dockerfile
FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

### ---------------Nginx-loadbalancer direcotory-----------------
De docker-compose.yaml bevat nu alleen de websiste app1.py. deze website gaan we opschalen.
we specifieren alleen de uitgaande poort zodat Nginx de ingaande poort kan mappen voor elke webserver

**docker-compose.yaml**
```yaml
version: '3'
services:
  app1:
    build: ./app1
    expose:
    - "5000"
  nginx:
    build: ./nginx 
    ports:
    - "8080:80"
    depends_on:
      - app1
```
<br>

Met de command hieronder worden er 2 app1 server opgespint en wordt tussen deze containers geloadbalanced 
```
docker-compose up -d --scale app1=2
```






# Docs
Nginx loadbalancer [Tutorial](https://dev.to/mazenr/how-to-implement-a-load-balancer-using-nginx-docker-4g73).
<br>
Tutorial [Code](https://github.com/mazen-r/articles/tree/main/nginx-docker-load-balancer/app1).
<br>
Nginx HTTP Loadbalancing [Documentation](https://nginx.org/en/docs/http/load_balancing.html).
<br>
Github .md [Guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).
<br>
Nginx Loadbalancer [Explained](https://dev.to/sammy_cloud/high-performance-loadbalancing-using-nginx-3f34).
<br>
Nginx proxy_pass [Explained](https://stackoverflow.com/questions/16111271/what-does-the-proxy-pass-option-in-the-nginx-config-do).






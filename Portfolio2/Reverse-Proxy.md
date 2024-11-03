## Reverse-proxy
Reverse proxy is een belangrijke onderdeel bij het hosten van een degelijke website zoals Tweakers.net of Bol.com. De reverse proxy word tussen de servers en gebruikers geplaats en wordt ook wel een midden men genoemd. In de afbeelding hieronder is te zien dat de gebruikers niet direct met de webserver praten, maar eerst langs de reverse proxy moet voor er enige diensten van de webserver worden toegelaten

![Alt text](https://www.vmware.com/media/blt8c9a8aaca0ffd4ac/blte2543aaa49490727/66d5870b17364fff67ef71f2/reverse-proxy-server-diagram_1.png)
 
Het belangrijkste doel van de reverse proxy is om de webservers binnen het netwerk te beschermen tegen de gebruikers zelf. Zo moeten de reverse proxy verzorgen dat het IP van de servers niet zichtbaar is richting de gebruikers. Dit doet de Reverse proxy door de webserver zijn IP te vervangen met die van zichzelf, zo dat gebruikers niet weten wat de IP van de webservers zijn.

Reverse proxy biedt nog iets belangrijk en dat is loadbalancing. Loadbalancing is een methode om een overload aan requesten bestemd voor een webserver te verminderen. De reverse proxy krijgt de overload aan requesten en verdeeld deze requesten over meerdere webservers. Hiermee kunnen meerdere gebruikers genieten van de website zonder dat de deze uitvalt en niet meer bereikbaar is.

Reverse proxy maakt het ook mogelijk om content zoals afbeeldingen, video’s en javascriptfiles op te slaan in de cache zodat andere gebruikers deze content sneller kan inladen. Dit is vooral bedoeld voor content dat vaak wordt opgevraagd door meerder gebruikers.

Al om al is een reverse proxy een belangrijk onderdeel van het netwerk, aangezien wij als gebruikers regelmatig websites bezoeken en dan is het erg fijn als de website stabiel zijn en snel inladen.

<br>
https://www.youtube.com/watch?v=sCR3SAVdyCc 
<br>
https://www.youtube.com/watch?v=RXXRguaHZs0 
<br>
https://www.youtube.com/watch?v=xo5V9g9joFs 
<br>
https://www.vmware.com/topics/reverse-proxy-server 
<br>
https://cyral.com/glossary/reverse-proxy/ 

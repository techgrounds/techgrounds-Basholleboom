# Firewalls
[Geef een korte beschrijving van het onderwerp]

## Key-terms
Stateful firewall - Stateful firewalls onthouden de verschillende states van vertrouwde actieve sessies. Hierbij hoeft een stateful firewall niet elke pakketje te scannen voor deze verbindingen  
Stateless firewall - A stateless firewall is one that doesn’t store information about the current state of a network connection. Instead, it evaluates each packet individually and attempts to determine whether it is authorized or unauthorized based on the data that it contains.
Hardware firewall - een fysiek apparaat dat dient als firewall, hierdoor hoef je niet individueel op iedere computer achter deze firewall nog iets te installeren
Software firewall - software op een apparaat dat dient als firewall  
ufw - Uncomplicated Firewall 

## Opdracht
### Gebruikte bronnen
[stateless firewall](https://www.checkpoint.com/cyber-hub/network-security/what-is-firewall/what-is-a-stateless-firewall/)  
[hardware en software firewall](https://www.fortinet.com/resources/cyberglossary/hardware-firewalls-better-than-software)  
[chromium op vm krijgen](https://linuxconfig.org/ubuntu-22-04-chromium-browser-installation)  
[apache installatie](https://cloud.google.com/compute/docs/tutorials/basic-webserver-apache)  
[apache connectie tip](https://httpd.apache.org/docs/2.4/platform/windows.html)  
[firewall notes](https://www.cyberciti.biz/faq/how-to-configure-firewall-with-ufw-on-ubuntu-20-04-lts/#Block_ports_with_ufw)  
[firewall status](https://www.baeldung.com/linux/firewall-status)
[bron ander](https://www.layerstack.com/resources/tutorials/Installing-Apache-server-on-Linux-Cloud-Servers)  
[UFW bron ubuntu](https://help.ubuntu.com/community/UFW)  
[forum ufw command tip](https://askubuntu.com/questions/448836/how-do-i-with-ufw-deny-all-outgoing-ports-excepting-the-ones-i-need)

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
#### notities firewalls
Stateful vs. Stateless Firewalls - Stateful houdt iets van de huidige status van het actieve netwerk bij, waardoor ze aanvallen kunnen blokkeren die stateless zou missen, oftewel, als er meerdere pakketten zijn die achter elkaar worden gestuurd voor controle kan de stateful hier fouten in vinden.  

nodig voor de opdracht: 
    Je Linux machine  
    Je unieke poortnummer voor http-verkeer  
ik neem aan dat mijn poortnummer gewoon 52214 is, waar ik ook mee connect  

#### Installeer een webserver op je VM.
chromium maar geïnstalleerd als browser mbv  
    sudo apt update  
    sudo apt install chromium-browser  

installatiebericht:  
![chromium install](Images/09-chromium-install.PNG)  

moet een webserver doen, niet webbrowser, maar dit is nog steeds leuk. 
apache2 had ik al geinstalleerd, met  
    sudo systemctl status apache2  
bevestigde ik dat het werkte

#### Bekijk de standaardpagina die met de webserver geïnstalleerd is via je browser op je pc/laptop.
gevonden manier om te verbinden: http://3.121.40.175:52214/  
geeft "De verbinding werd geherinitialiseerd"  
verbinden met Deniz werkt wel  
als ik mijn apache2 server stop dan krijg ik nog steeds zelfde melding  
52214 is ssh, moet met web port  
http://3.121.40.175:58014/  
![apache2 werkt](Images/10-apache2-running.PNG) 

#### Stel de firewall zo in dat je webverkeer blokkeert, maar wel ssh-verkeer toelaat.

    sudo ufw enable  

    sudo ufw default deny outgoing  
    sudo ufw default deny incoming  
    sudo ufw allow ssh  

#### Controleer of de firewall zijn werk doet.
gecontroleerd met  
    sudo ufw status verbose  
![succes](Images/10-firewall-on.PNG)
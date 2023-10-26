# Processes
[Geef een korte beschrijving van het onderwerp]

## Key-terms
Process categorieën: Daemons, Services, and Programs  
Daemon - background, non-interactive  
Service - responds to requests from programs, interactive  
Programs - run and used by users  
telnet - unencrypted connection service, only used in this excercise, otherwise unsafe.

## Opdracht
### Gebruikte bronnen
[mogelijk startup command systemctl](https://phoenixnap.com/kb/telnet-linux)  
[systemctl uitleg](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)  
[telnet command uitleg](https://www.ionos.com/digitalguide/server/tools/telnet-commands/)  
[get pid of a just-startet process](https://www.baeldung.com/linux/just-started-process-pid)

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
door gewoon <telnet> te typen lijk ik al in telnet te komen....  
![startup](/01_Linux_1/images/8-telnetstartup+questionmark.PNG)  
telnet PID gekregen via pgrep  
![pid](/01_Linux_1/images/8-telnet-pid.PNG)  

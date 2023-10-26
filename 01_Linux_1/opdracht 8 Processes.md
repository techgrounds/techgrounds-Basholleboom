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
[eerste bron poging memory vinden](https://phoenixnap.com/kb/linux-commands-check-memory-usage)  
[uitleg colommen top command](https://www.howtogeek.com/668986/how-to-use-the-linux-top-command-and-understand-its-output/)
[filteren in top](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-how-to-kill-a-process-from-the-command-line)  
[force killen me t-9](https://phoenixnap.com/kb/how-to-kill-a-process-in-linux)
### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
door gewoon <telnet> te typen lijk ik al in telnet te komen....  
![startup](/01_Linux_1/images/8-telnetstartup+questionmark.PNG)  
telnet PID gekregen via pgrep  
![pid](/01_Linux_1/images/8-telnet-pid.PNG)  
gebruik top of htop command voor info  
top memory list  
![top](/01_Linux_1/images/8-top-memory.PNG)  
htop memory list  
![htop](/01_Linux_1/images/8-htop-memory.PNG)  
top met filter  
![filtered](/01_Linux_1/images/8-top-filter.PNG)  
force kill met -9  
![kill](/01_Linux_1/images/8-kill.PNG)  
kill kan ook door in top 'k' in te drukken, de PID te typen, en na nog een enter '9' te typen

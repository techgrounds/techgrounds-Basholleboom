# Users & Groups
creëren van nieuwe user

## Key-terms
root - mag alles doen in een server
sudo - geeft iemand tijdelijk root

## Opdracht
### Gebruikte bronnen
sudo uitleg binnen cmd  
![sudo uitleg binnen cmd](/01-Linux/images/6-sudo-user-note-cmd.PNG)  
[add users and give them password](https://support.stackpath.com/hc/en-us/articles/360025308732-Add-Users-to-a-Virtual-Machine)  
[cheatsheet linux commands](https://phoenixnap.com/kb/linux-commands-cheat-sheet#users-and-groups)  
[shadow file informatie over password](https://linuxize.com/post/etc-shadow-file/)
### Ervaren problemen
Begreep vraag vinden van user files niet goed; heb medestudenten om hulp gevraagd.

### Resultaat
met sudo adduser <naam> nieuwe user toegevoegd, vroeg automatisch om aanmaak password  
![nieuwe user](../01-Linux/images/user-with-password-added.PNG)  
Nu kijken naar admin groep gedeelte  
groep aangemaakt, user aan groep toegevoegd.  
![group](../01-Linux/images/admin-group.PNG)  
locating files that store user data  
binnen /etc/ lijkt user data te staan. met grep <username> /etc/passwd krijg ik dit als output  
![passwd grep](../01-Linux/images/grep-originele-naam-pwd.PNG)  
Noot: met /etc/shadow kan je het versleutelde password zien.
# Users & Groups
creëren van nieuwe user

## Key-terms
root - mag alles doen in een server
sudo - geeft iemand tijdelijk root

## Opdracht
### Gebruikte bronnen
sudo uitleg binnen cmd  
![sudo uitleg binnen cmd](01_Linux_1\opdracht 6 Users & Groups.md)  
[add users and give them password](https://support.stackpath.com/hc/en-us/articles/360025308732-Add-Users-to-a-Virtual-Machine)  
[cheatsheet linux commands](https://phoenixnap.com/kb/linux-commands-cheat-sheet#users-and-groups)

### Ervaren problemen


### Resultaat
met sudo adduser <naam> nieuwe user toegevoegd, vroeg automatisch om aanmaak password  
![nieuwe user](../01_Linux_1/images/user-with-password-added.PNG)  
Nu kijken naar admin groep gedeelte  
groep aangemaakt, user aan groep toegevoegd.  
![group](../01_Linux_1/images/admin-group.PNG)  
locating files that store user data  
binnen /etc/ lijkt user data te staan. met grep <username> /etc/passwd krijg ik dit als output  
![passwd grep](../01_Linux_1/images/grep-originele-naam-pwd.PNG)

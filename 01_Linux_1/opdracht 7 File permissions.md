# File permissions
aanpassen van de permissies van een text document

## Key-terms
rwx - reading, writing, and executing files

## Opdracht
### Gebruikte bronnen
[eerder gebruikte site met algemene command informatie, voor specifiek zie afbeelding](https://www.pluralsight.com/guides/beginner-linux-navigation-manual)  
![permission commands](01_Linux_1\images\7-Permissions-overview.PNG)  
de laatste 9 karakters van de tiencijferige code voor een document na een ls-l laat de access zien. met chmod kan je daarin aanpassingen maken.  
[wikipedia chmod](https://en.wikipedia.org/wiki/Chmod) [meer wiki](https://en.wikipedia.org/wiki/File-system_permissions#Traditional_Unix_permissions)  
[chgrp-veranderen van group owner](https://www.atlantic.net/dedicated-server-hosting/how-to-use-chgrp-change-group-ownership-command-in-linux/)
### Ervaren problemen


### Resultaat
eerste analyse, aanmaken, permission change, readpoging  
![eerste analyse, aanmaken, permission change, readpoging](/01_Linux_1/images/7-aanmaken-test-chmod-enkel-execute-ownerread-only.PNG)  
owner change naar originelenaam  
![owner change naar originelenaam](/01_Linux_1/images/7-ownership-change-nonowner-read.PNG)  
analyse inclusief groep+group change  
![analyse inclusief groep+group change](/01_Linux_1/images/7-groupinfo+groupchange.PNG)
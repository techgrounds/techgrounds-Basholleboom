# Networking case study
[Geef een korte beschrijving van het onderwerp]

## Key-terms
DMZ - Demilitarized zone

## Opdracht
### Gebruikte bronnen
[herhaling uitleg switch](https://www.youtube.com/watch?v=9eH16Fxeb9o)  
mooi schematisch overview inclusief firewall  
![mooi schematisch overview inclusief firewall](Images/07-router-overview.PNG)  
[bonus filmpje week 2](https://www.youtube.com/watch?v=oopkClg1kxM)

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Needed:  
    A web server where our webshop is hosted
    A database with login credentials for users on the webshop
    5 workstations for the office workers
    A printer
    An AD server
    A file server containing internal documents  

Network security is important  
AD server seems to be advertising server  
10 connecties zonder route; gebruik /28 voor 14 usable hosts  
Herinnering: switches zijn voor in hetzelfde netwerk; alle interne apparatuur zit dus aan een switch zodat ze ook met elkaar kunnen communiceren. De switch zit aan de router. De switch heeft zelf geen IP adres.  

Resultaat:  
![resultaat](Images/07-diagram-color.png)  
Medestudent: Database server met login credentials zit vaak in een losse set volgens het concept van een dmz - demilitarized zone:  
![dmz](Images/07-DMZ-bron.png)  
Heb een versie gemaakt met een losse switch set voor het web service gedeelte voor de veiligheid. Volgens mij kan ik de huidige subnets bewaren?  
![resultaat+dmz](Images/07-diagram-dmz.png)  
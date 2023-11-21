# [Onderwerp]


## Key-terms
ALB - Azure Load Balancer  

## Opdracht
### Uitwerking en Resultaat

#### Exercise 1 Setup
zie niets staan over poorten, moet wel een virtueel netwerk aanmaken  

    #!/bin/bash
    sudo su
    apt update
    apt install apache2 -y
    ufw allow 'Apache'
    systemctl enable apache2
    systemctl restart apache2


#### Exercise 2 Controleer of je via het endpoint van je load balancer bij de webserver kan komen. Voer een load test uit op je server(s) om auto scaling the activeren. Er kan een delay zitten in het creëren van nieuwe VMs, afhankelijk van de settings in je VM Scale Set. Let op: de Azure Load Testing service kan prijzig zijn. Je kan ook inloggen op de VM om een handmatige stress test te doen.
Heb handmatig poort 22 en 80 toegestaan in 'netwerken' in de scaler, heb dubbel gecontroleerd of dit goed werkte door mijn http poort uit en weer aan te zetten, als ik het ip van een van de VM's gebruik laat hij de site zien.  

Heb vervolgens een Azure Load Testing resource aangemaakt, deze heb ik vervolgens laten runnen op het ip van mijn enige overgebleven vm  
50 users over 5 minuten zorgde niet voor een nieuwe vm, probeer nu 50 in 1 minuut  
als ik bij de metrieken van de VM kijk zie ik dat de cpu bij mijn eerdere testen maximaal 40% haalde, probeer nu 500 users over 5 minuten, 
tip van teamgenoot: ab -n in de command promt doet een load test  
Tip 2: bij aanmaken gaan naar netwerken: taakverdeling> azure load balancer  
met deze nieuwe instellingen heb ik nu wel een openbaar ip: 20.16.192.179  
webpagina doet het met dit ip  
gewacht tot 1 vm over was, start test met 1000 users  
na het verlagen van de upscale drempel voegt hij braaf VMs toe


NOOT: stresstesten is duur  


### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]
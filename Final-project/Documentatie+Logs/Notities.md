middelklein kantoorbedrijf
alleen website+database
vms moeten alleen voor website server en ed




# Wat zijn de vereisten en welke services ga ik daarvoor gebruiken

    Alle VM disks moeten encrypted zijn.
    De webserver moet dagelijks gebackupt worden. De backups moeten 7 dagen behouden worden.
    De webserver moet op een geautomatiseerde manier geïnstalleerd worden.
    De admin/management server moet bereikbaar zijn met een publiek IP.
    De admin/management server moet alleen bereikbaar zijn van vertrouwde locaties (office/admin’s thuis)
    De volgende IP ranges worden gebruikt: 10.10.10.0/24 & 10.20.20.0/24
    Alle subnets moeten beschermd worden door een firewall op subnet niveau.
    SSH of RDP verbindingen met de webserver mogen alleen tot stand komen vanuit de admin server.
    Wees niet bang om verbeteringen in de architectuur voor te stellen of te implementeren, maar maak wel harde keuzes, zodat je de deadline kan halen.

## Algemene encryptie
optie binnen services

## firewalls en NSGs
Azure firewall  
Azure Network Security Groups (NSG) in services

## subnets
in azure VNet

## scaleable database (voor webserver)
SQL database

## webserver VM (linux) met bereikbaarheid via internet

## VM admin/management server voor beperkt publiek

## mogelijk aparte database voor admin server

## 1 admin

## Backup met RPO van 24u, RTO van 1u

## mogelijkheden/ruimte voor latere workstations

## opslaglocatie voor bootstrap/post-deployment scripts
Mijn aanname voor nu is dat dit samen met de opslag voor de admin kan, aangezien beiden interne/backup elementen zijn. De webserver moet vooral zijn eigen opslag hebben aangezien die het meest in contact staat met de buitenwereld/andere vereisten heeft  
Ik neem voor nu aan dat de backup met zijn specifieke vereisten ook een eigen database heeft
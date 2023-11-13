# Azure Global Infrastructure


## Key-terms
Azure Region - An Azure region is a set of datacenters, deployed within a latency-defined perimeter and connected through a dedicated regional low-latency network.  
Azure Availability Zone -  Azure Availability Zones are unique physical locations within an Azure region and offer high availability to protect your applications and data from datacenter failures. Each zone is made up of one or more datacenters equipped with independent power, cooling, and networking. The physical separation of availability zones within a region protects apps and data from facility-level issues. Zone-redundant services replicate your apps and data across Azure Availability Zones to protect from single points of failure.  

Kortom: meerdere Datacenters in één regio die los van elkaar staan om complicaties bij stroomuitval/locale rampen ed. op te vangen

Azure Region Pair - Aan elkaar verbonden regions die dmv Cross-region replication zich beschermen tegen grotere rampen

## Opdracht
### Uitwerking en Resultaat
#### Exercise 1 Waarom zou je een regio boven een andere verkiezen?
Proximity voor weinig latency, capacity, kosten

### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[Azure global infrastructure](https://azure.microsoft.com/en-us/explore/global-infrastructure/)  
[Azure availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview?tabs=azure-cli)  
[Azure region pairs](https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure)  
[select Azure regions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-setup-guide/regions)  
# Detection, response & analysis


## Key-terms
Malware - malicious software  
IDS - intrusion detection systems  
IPS - intrusion protection systems  
RPO - recovery point objective  
RTO - recovery time objective  
Synchronous replication - constante backups voor lage rto en rpo, backup server moet wel fysiek in de buurt zijn  
Asynchronous replication - backup eens in de zoveel tijd op een server ver weg; goed voor extreme situaties als natuurrampen  
Mixed technique - synchronous en asynchronous replication tegelijk

## Opdracht
### Resultaat
Study:  
    IDS and IPS.  
    Hack response strategies.  
    The concept of systems hardening.  
    Different types of disaster recovery options.  


#### Exercise 1 A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?
RPO=recovery point objective; amount data lost. Verlies is alles nadat de laatste daily backup is gemaakt. 

#### Exercise 2 An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?
RTO is tijd nodig tot alles weer online is, hier is dat 8 minuten

### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[ids vs ips](https://www.spiceworks.com/it-security/network-security/articles/ids-vs-ips/)  
[ids vs ips 2](https://www.varonis.com/blog/ids-vs-ips)  
[ids/ips wiki](https://en.wikipedia.org/wiki/Intrusion_detection_system)  
[ids and ips](https://www.youtube.com/watch?v=cMH4yGE73iQ)  
[7 Steps to Building a Disaster Recovery Plan](https://www.youtube.com/watch?v=Ipf3nXsgC3M)  
[3 disaster recovery techniques](https://www.criticalcase.com/blog/3-disaster-recovery-techniques.html)
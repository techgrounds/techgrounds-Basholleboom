# Cron Jobs
Making tasks run on a schedule

## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Gebruikte bronnen
[date in script info](https://www.cyberciti.biz/faq/unix-linux-getting-current-date-in-bash-ksh-shell-script/)  
[chrontab.guru](https://crontab.guru/)
[chrontab info](https://phoenixnap.com/kb/set-up-cron-job-linux)  
medestudent comment: sudo timedatectl >> currenttime.txt Als je dit in .sh script plaats dan werkt het
### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
    now=$(date)
    echo "$now"
hiermee print hij de datum locaal  
dat.sh als script, dats.txt als storage

dat.sh  
    now=$(date)
    echo "$now">>/home/dats.txt  

    crontab -e
dit opent chronjob bestand, heb ingesteld op nano als editor

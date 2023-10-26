# Bash Scripts
Maken van scripts map en oefenen met Bash scripts

## Key-terms
Bash script - series of commands written in text file  
PATH variable - iets waaraan je je scriptmap toevoegt zodat linux het kan vinden

## Opdracht
### Gebruikte bronnen
[add a directory to PATH](https://phoenixnap.com/kb/linux-add-to-path)  

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Met echo $PATH laat hij de geconfigureerde directories zien  
    export PATH="/home/bas/scripts:$PATH">>.bashrc  
hiermee locatie toegevoegd; NOOT: deed dit per ongeluk 2x in de .bash ipv .bashrc  
![echo voor/na + toevoeging map](images/9-echo-addpath-echo.PNG)
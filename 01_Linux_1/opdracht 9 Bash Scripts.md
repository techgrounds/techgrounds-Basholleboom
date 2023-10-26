# Bash Scripts
Maken van scripts map en oefenen met Bash scripts

## Key-terms
Bash script - series of commands written in text file  
PATH variable - iets waaraan je je scriptmap toevoegt zodat linux het kan vinden  
append - 

## Opdracht
### Gebruikte bronnen
[add a directory to PATH](https://phoenixnap.com/kb/linux-add-to-path)  
[running .sh file](https://www.cyberciti.biz/faq/run-execute-sh-shell-script/)

### Ervaren problemen
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Resultaat
Met echo $PATH laat hij de geconfigureerde directories zien  
    export PATH="/home/bas/scripts:$PATH">>.bashrc  
hiermee locatie toegevoegd; NOOT: deed dit per ongeluk 2x in de .bash ipv .bashrc  
![echo voor/na + toevoeging map](images/9-echo-addpath-echo.PNG)  
"Create a script that appends a line of text to a text file whenever it is executed" append is dus achter aan toevoegen, dus gewoon ">>" gebruiken  
met <echo >appenderino.sh> eerste bash aangemaakt, met <echo ">>a line of text">appenderino.sh> het command voor het toevoegen van "a line of text" toegevoegd
moet het appenden naar een specifiek text file doen  
hermaakte appenderino.sh met <touch appenderino.sh>, vervolgde met <echo "a line of text>>../bas/techgrounds/text2.txt">>appenderino.sh>  
nu appenderino executable maken voor mezelf  
![gedaan](images/9-chmod-herinnering.PNG)  
met ./<.sh file> kan je executen  
herkende locatie niet  
![fail](images/9-run-1-fail.PNG)  
juiste command was <echo "echo a line of text>>../techgrounds/text2.txt">>append.sh>  
![success](images/9-append-succes.PNG)  
  
Next: Create a script that installs the httpd package, activates httpd, and enables httpd. Finally, your script should print the status of httpd in the terminal.: 

Created h.sh for this purpose  

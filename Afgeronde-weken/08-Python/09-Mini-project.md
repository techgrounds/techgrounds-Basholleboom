# Mini project


## Key-terms
[Schrijf hier een lijst met belangrijke termen met eventueel een korte uitleg.]

## Opdracht
### Uitwerking en Resultaat
#### Exercise 1
Begin maar met number guessing  

gebruik RNG van 06-script1  
gebruik feedback proces van 05-script2  

Code voor Number Guessing game:  

    import random  

    # De speler moet raden, geef een hint na een antwoord  
    x=random.randrange(1, 100)      #definieert x met een willekeurig getal tussen de 1 en 100  
    y=0                             #defineert y  
    count=1                         #start een teller op 1  
    while y != x:                   #start loop tot het juiste getal wordt ingevoerd  
        y=input("uw nummer ", )  
        x=int(x)                    #zet x naar type integer  
        y=int(y)  
        if y < x:  
            print("laag")  
            count += 1              # verhoogt ronde met 1  
        if y > x:  
            print("hoog")  
            count += 1              # verhoogt ronde met 1  
        if y == x:   
            print("nice", "rondes nodig: ", count)  

#### Exercise 2
Rock Paper Scissors
Ipv bij rng moet er nu in een beperkt aantal rondes steeds opnieuw willekeurig rock, paper, of scissors worden gekozen. Hiernaast moet er aan het einde een scoretracker worden bijgehouden  

Misschien moet ik de drie dingen binden aan variables  
Door getallen te gebruiken als variables kan ik de randomise.randrange gebruiken  
De vraag is of dit goed gaat werken met het feit dat de speler specifiek "rock" "paper" of "scissors" in moet voeren.  

### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[Plaats hier de bronnen die je hebt gebruikt.]
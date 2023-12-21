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

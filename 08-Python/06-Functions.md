# Functions


## Key-terms
Function - block of code that only runs when it is called

## Opdracht
### Uitwerking en Resultaat
#### Exercise 1
Code:  
    # hiermee laat ik dit 5 keer loopen  
    for x in range(5):  
        # hiermee kan ik random nummers genereren  
        import random  
        # dit geeft een range tussen 0 en 100  
        x=random.randrange(0, 100)  
        print(x)  

#### Exercise 2
Code deel 1:  
    def myfunction():  
        print("Hello World!")  
    myfunction()  

nu herschrijven zodat hij een string als argument neemt  

    def myfunction(NAAM):  
        print("Hello, " + NAAM +"!")  
    myfunction("Bas")  

Hiermee print hij: Hello Bas! ; in de myfunction onderaan kan ik de naam aanpassen om steeds een andere naam te laten zien  

#### Exercise 3
gegeven code:  
    def avg():  
    # write your code here  
    # you are not allowed to edit any code below here  

    x = 128  
    y = 255  
    z = avg(x,y)  

    print("The average of",x,"and",y,"is",z)  


Uiteindelijke code:  
    def avg(x,y):  
        z=((x+y)/2)  
        return z  

    # write your code here  
    # you are not allowed to edit any code below here  

    x = 128  
    y = 255  
    z = avg(x,y)  

    print("The average of",x,"and",y,"is",z)  

Het lijkt niet uit te maken wat ik in de bovenste avg tussen de haakjes zet  
    def avg(num1,num2):  
        z=((num1+num2)/2)  

werkt ook

### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[module import](https://docs.python.org/3/tutorial/modules.html)  
[RNG doc](https://docs.python.org/3/library/random.html)  
[functions](https://www.w3schools.com/python/python_functions.asp)  
[functions youtube](https://www.youtube.com/watch?v=89cGQjB5R4M)  
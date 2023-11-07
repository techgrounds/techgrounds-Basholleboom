# Public key infrastructure


## Key-terms
PKI - Public Key Infrastructure  
X.509 - standard for PKI  

## Opdracht
### Resultaat
#### Exercise 1 Create a self-signed certificate on your VM
Heb het voorbeeld gebruikt van bron 2:  
openssl req -newkey rsa:4096 \  
            -x509 \  
            -sha256 \  
            -days 3650 \  
            -nodes \  
            -out example.crt \  
            -keyout example.key  

Certificatie aanmaak:  
![certificatie aanmaak](Images/05-certificate1.PNG)  

.crt en .key  
![crt](Images/05-examplecrt.PNG)
![key](Images/05-examplekey.PNG)  


### Ervaren problemen
#### Exercise 1
[Geef een korte beschrijving van de problemen waar je tegenaan bent gelopen met je gevonden oplossing.]

### Gebruikte bronnen
[x.509](https://en.wikipedia.org/wiki/X.509)  
[creating self-signed certificate](https://linuxize.com/post/creating-a-self-signed-ssl-certificate/)  
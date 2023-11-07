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

Mooie uitleg codes van bron 2:  
    -newkey rsa:4096 - Creates a new certificate request and 4096 bit RSA key. The default one is 2048 bits.  
    -x509 - Creates a X.509 Certificate.  
    -sha256 - Use 265-bit SHA (Secure Hash Algorithm).  
    -days 3650 - The number of days to certify the certificate for. 3650 is ten years. You can use any positive integer.  
    -nodes - Creates a key without a passphrase.  
    -out example.crt - Specifies the filename to write the newly created certificate to. You can specify any file name.  
    -keyout example.key - Specifies the filename to write the newly created private key to. You can specify any file name.  

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
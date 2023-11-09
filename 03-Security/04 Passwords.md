# Passwords


## Key-terms
Hashing - transforming of key or string into another value, using hash tables, kan data van een willekeurige grootte binden aan een waarde van een standaard grootte.  
Rainbow table - as per wiki: A rainbow table is a precomputed table for caching the outputs of a cryptographic hash function, usually for cracking password hashes.  
Salting - willekeurige data toevoegen aan iets voordat je het hashed, zo kan je er bijvoorbeeld voor zorgen dat als 2 mensen hetzelfde wachtwoord hebben ze toch met een verschillende hash eindigen

## Opdracht
### Resultaat
Hashing: Goed voor data storage en retrieval, wel gevaar voor overlap codes.Als je 1 bit verandert veranderd de hash totaal. Kan slechts dmv veel computerkracht terug van hash naar file, hierdoor geschikt om bijvoorbeeld wachtwoorden op een server op te slaan; je kan kijken of iemand het juiste wachtwoord invuld zonder daadwerkelijk het wachtwoord te hebben

#### Exercise 1 Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.
resultaat na hash cracker:  
03F6D7D1D9AAE7160C05F71CE485AD31	md5	welldone!  
03D086C9B98F90D628F2D1BD84CFA6CA	Unknown	Not found.  

#### Exercise 2 Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.
    sudo adduser passwordenjoyer  
wachtwoord: 12345  
    sudo grep passwordenjoyer /etc/shadow  
    passwordenjoyer:$6$cpww45knJsT9o0Ao$hOHpGpXtXJBsgaxuhfbXmgZ5PwWW9RH53V.D3gQ66xShHxOizuuCn7NnHz5ZLvvwZ/gHbHotj8QTNOZ8tchML1:19668:0:99999:7:::  
begin code is $6$, dus SHA-512  
sudo cat /etc/shadow geeft de dingen van iedereen weer, dus grep is beter  
krijg steeds "unrecognized hash format"  
resultaat Allard: $6$Qn.HX4XmpYck092S$AbZHVH/Ld5wQe2NoiQ52PklcwaTlviWLrgkr8fKuu5VgdgtbIVmcAJUGUXvAsMsGKXHFxDMSc5AzqK8mZqc5k1:19668:0:99999:7:::  
dit is net anders, omdat de data deels anders is, oa. met salting. Voor ons beiden is het gehashed als SHA-512, alles na de dubbele punt is weer hetzelfde


### Ervaren problemen
#### Exercise 1
krijg steeds "unrecognized hash format", weet niet of dit het bedoelde resultaat is, controleer met de anderen als ze er ook zijn  

### Gebruikte bronnen
[online rainbow table](https://crackstation.net/)  
[hashing](https://www.techtarget.com/searchdatamanagement/definition/hashing#:~:text=Hashing%20is%20the%20process%20of,the%20implementation%20of%20hash%20tables.)  
[hash function](https://en.wikipedia.org/wiki/Hash_function)  
[rainbow table](https://en.wikipedia.org/wiki/Rainbow_table)  
[unshadow note](https://askubuntu.com/questions/383057/how-to-decode-the-hash-password-in-etc-shadow)  
[symmetric, asymmetric, and hashing](https://www.encryptionconsulting.com/education-center/encryption-vs-hashing/)
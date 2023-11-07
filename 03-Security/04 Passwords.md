# Passwords


## Key-terms
Hashing - transforming of key or string into another value, most often used in hash tables  
Rainbow table - as per wiki: A rainbow table is a precomputed table for caching the outputs of a cryptographic hash function, usually for cracking password hashes.  

## Opdracht
### Resultaat
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


### Ervaren problemen
#### Exercise 1
krijg steeds "unrecognized hash format", weet niet of dit het bedoelde resultaat is  

### Gebruikte bronnen
[online rainbow table](https://crackstation.net/)  
[hashing](https://www.techtarget.com/searchdatamanagement/definition/hashing#:~:text=Hashing%20is%20the%20process%20of,the%20implementation%20of%20hash%20tables.)  
[hash function](https://en.wikipedia.org/wiki/Hash_function)  
[rainbow table](https://en.wikipedia.org/wiki/Rainbow_table)  
[unshadow note](https://askubuntu.com/questions/383057/how-to-decode-the-hash-password-in-etc-shadow)
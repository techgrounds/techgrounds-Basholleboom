# Setting up
Inloggen op de Linux server

## Key-terms
SSH  
Virtual Machine  
Key File
## Opdracht
### Gebruikte bronnen
[installatie check SSH](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell)  
[uitleg commands](https://www.clickittech.com/aws/connect-ec2-instance-using-ssh/)  
[ubuntu user management](https://ubuntu.com/server/docs/security-users)  

### Ervaren problemen
Ik wist niet dat ik de poort moest toevoegen achter het IP-adres tot een medestudent dat aankaartte.

### Resultaat
Connection established. In command prompt eerst met cd directory veranderen naar waar ssh key is, dan met  
    ssh -i <key file naam> <inlognaam@serverip -p<poort>>  
    eg  
    ssh -i Nest-ba-holleboom.pem bas@3.121.40.175 -p52214  
inloggen

![eerste connectie](/01_Linux_1/images/setup1.png)   
![tweede connectie na verplaatsting key](/01_Linux_1/images/setup2.png)

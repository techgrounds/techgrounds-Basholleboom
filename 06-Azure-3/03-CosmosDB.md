# CosmosDB

## Theorie
### Welk probleem lost X op?
fully managed NoSQL and relational database for modern app development  
het verwerken van veel datarequests tegelijk dmv horizontal scaling  
werkt voor veel verschillende services, oa: NoSQL, MongoDB, Cassandra, PostgreSQL  

### Welke key termen horen bij X?
Horizontal scaling/scaling out  
partitioning logical/physical  
replication  
RU - request units, throughput measure, hier is de prijs van CosmosDB op gebaseerd  

### Hoe past X / vervangt X in een on-premises setting?

### Hoe kan ik X combineren met andere diensten?
datastorage voor andere diensten  

### Wat is het verschil tussen X en andere gelijksoortige diensten?
Voor zowel relational als nonrelational data, focused on horizontal scalability  

## Praktijk
### Waar kan ik deze dienst vinden in de console?
Azure Cosmos DB  

### Hoe zet ik deze dienst aan?
Creër een Azure Cosmos DB account  
na aanmaken wil hij bij een quick start een container opzetten  
vervolgens wil hij dat ik een .NET app download  
Tenslotte kan ik werken, zo te zien opent hij de app in Microsoft Visual Studio  

### Hoe kan ik deze dienst koppelen aan andere resources?
Data kan vermoedelijk in andere diensten worden gebruikt. CONTROLEER DIT MET ANDEREN  
"Deeply integrated with key Azure services used in modern (cloud-native) app development including Azure Functions, IoT Hub, AKS (Azure Kubernetes Service), App Service, and more."  

readme info om te koppelen aan Microsoft Visual Studio  
1. Clone this repository using Git for Windows (http://www.git-scm.com/), or download the zip file.  

1. From Visual Studio, open the **GetStarted.sln** file from the root directory.  

1. In Visual Studio Build menu, select **Build Solution** (or Press F6).   

1. Retrieve the URI and PRIMARY KEY (or SECONDARY KEY) values from the Keys blade of your Azure Cosmos DB account in the Azure portal. For more information on obtaining endpoint & keys for your Azure Cosmos DB account refer to [View, copy, and regenerate access keys and passwords](https://docs.microsoft.com/en-us/azure/cosmos-db/manage-account#keys)  

If you don't have an account, see [Create a database account](https://docs.microsoft.com/azure/cosmos-db/create-sql-api-dotnet#create-a-database-account) to set one up.  

1. In the **App.config** file, located in the src directory, find **EndPointUri** and **PrimaryKey** and replace the placeholder values with the values obtained for your account.  

    <add key="EndPointUri" value="~your Azure Cosmos DB endpoint here~" />  
    <add key="PrimaryKey" value="~your auth key here~" />  

1. You can now run and debug the application locally by pressing **F5** in Visual Studio.  

In de zip die ik had gedownload was dit al automatisch gedaan.  

kan verder geen nieuwe container maken met de beperkte toewijzingen die ik heb.  

## Notities

### Ervaren problemen

### Gebruikte bronnen
[learn](https://learn.microsoft.com/en-us/azure/cosmos-db/introduction)  
[microsoft youtuber](https://www.youtube.com/watch?v=Jvgh64rvdXU&list=PLLasX02E8BPDd2fKwLCHnmWoyo4bL-oKr)  
[adam marczak](https://www.youtube.com/watch?v=R_Fi59j6BMo)  
[more adam](https://www.youtube.com/watch?v=RqD4nMyBazU&list=PLGjZwEtPN7j-Q59JYso3L4_yoCjj2syrM&index=13)
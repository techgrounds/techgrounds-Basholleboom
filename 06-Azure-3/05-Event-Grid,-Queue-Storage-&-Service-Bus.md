# Event Grid, Queue Storage & Service Bus

## Theorie
### Welk probleem lost X op?
Azure Event Grid is a highly scalable, fully managed Pub Sub message distribution service that offers flexible message consumption patterns using the MQTT and HTTP protocols. Fully-managed event routing service  
Azure Queue Storage is a service for storing large numbers of messages. A queue message can be up to 64 KB in size.  
Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics (in a namespace). Service Bus is used to decouple applications and services from each other  

### Welke key termen horen bij X?
event - wat er gebeurde  
event source - in welke resource dat gebeurde  
pub-sub - Publish–subscribe pattern, messaging pattern where publishers categorize messages into classes that are received by subscribers. This is contrasted to the typical messaging pattern model where publishers send messages directly to subscribers.   

### Hoe past X / vervangt X in een on-premises setting?

### Hoe kan ik X combineren met andere diensten?
Event grid kan combineren met andere diensten dmv Event Grid Topics  
Queue Storage lijkt een optie te zijn binnen storage accounts  


### Wat is het verschil tussen X en andere gelijksoortige diensten?
In tegenstelling tot andere message brokers als apache is Service Bus een PaaS, die dus dingen als hardware en backup onderhoudt  

## Praktijk
### Waar kan ik deze dienst vinden in de console?

### Hoe zet ik deze dienst aan?
Event Grid Service  
Queue Storage lijkt een optie te zijn binnen storage accounts 
Service Bus Service  

### Hoe kan ik deze dienst koppelen aan andere resources?

## Notities
Vermoedde reden tot samenvoeging onderwerpen in 1 punt: Event Grid rout messages, Queue Storage slaat ze op, en Service Bus zorgt voor communicatie tussen applicaties; gaat allemaal over messages en kunnen mogelijk elkaar hierin ondersteunen  

### Ervaren problemen

### Gebruikte bronnen
[event grid](https://learn.microsoft.com/en-us/azure/event-grid/overview)  
[adam marczak event grid](https://www.youtube.com/watch?v=TujzkSxJzIA)  
[queue storage](https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction)  
[service bus](https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview)  
[microsoft youtube service bus](https://www.youtube.com/watch?v=kfjUSibSico)  
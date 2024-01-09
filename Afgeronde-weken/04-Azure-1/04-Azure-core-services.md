# Azure core services


## Key-terms
SQL - Structured query language  
Kubernetes - open-source container orchestration system for automating software deployment, scaling, and management.  

## Opdracht
### Uitwerking en Resultaat
#### Exercise 1
Regions and Region Pairs - An Azure region is a set of datacenters, deployed within a latency-defined perimeter and connected through a dedicated regional low-latency network. Connected regions which protect against larger scale disasters through cross-region replication  
Availability Zones - Azure Availability Zones are unique physical locations within an Azure region and offer high availability to protect your applications and data from datacenter failures.  
Resource Groups - A resource group is a container that holds related resources for an Azure solution.  
Subscriptions - Azure Subscriptions are a logical unit of Azure services that are linked to an Azure account  
Management Groups - Management groups provide a governance scope above subscriptions. You organize subscriptions into management groups; the governance conditions you apply cascade by inheritance to all associated subscriptions.  
Azure Resource Manager - Azure Resource Manager is the deployment and management service for Azure  
Virtual Machines - on-demand, schaleable computer resource  
Azure App Services - HTTP-based service for hosting web applications, REST APIs, and mobile back ends  
Azure Container Instances (ACI) - way to package, deploy, and manage cloud applications  
Azure Kubernetes Service (AKS) - Azure Kubernetes Service (AKS) simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. As a hosted Kubernetes service, Azure handles critical tasks, like health monitoring and maintenance.  
Azure Virtual Desktop - a desktop and app virtualization service that runs on the cloud.  
Virtual Networks - Azure Virtual Network is a service that provides the fundamental building block for your private network in Azure. An instance of the service (a virtual network) enables many types of Azure resources to securely communicate with each other, the internet, and on-premises networks. These Azure resources include virtual machines (VMs).  
VPN Gateway - a service that uses a specific type of virtual network gateway to send encrypted traffic between an Azure virtual network and on-premises locations over the public Internet
Virtual Network Peering - enables you to seamlessly connect two or more Virtual Networks in Azure  
ExpressRoute - ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure and Microsoft 365.  
Container (Blob) Storage - Azure Blob Storage is Microsoft's object storage solution for the cloud. Blob Storage is optimized for storing massive amounts of unstructured data  
Disk Storage - block-level storage volumes that are managed by Azure and used with Azure Virtual Machines. 
File Storage - file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API.  
Storage Tiers - to manage costs for storage needs it gets divided into tiers:  
    Hot tier - An online tier optimized for storing data that is accessed or modified frequently. The hot tier has the highest storage costs, but the lowest access costs.  
    Cool tier - An online tier optimized for storing data that is infrequently accessed or modified. Data in the cool tier should be stored for a minimum of 30 days. The cool tier has lower storage costs and higher access costs compared to the hot tier.  
    Cold tier - An online tier optimized for storing data that is infrequently accessed or modified. Data in the cold tier should be stored for a minimum of 90 days. The cold tier has lower storage costs and higher access costs compared to the cool tier.  
    Archive tier - An offline tier optimized for storing data that is rarely accessed, and that has flexible latency requirements, on the order of hours. Data in the archive tier should be stored for a minimum of 180 days.  

Cosmos DB - fully managed NoSQL and relational database for modern app development  
Azure SQL Database - fully managed platform as a service (PaaS) database engine that handles most of the database management functions such as upgrading, patching, backups, and monitoring without user involvement.  
Azure Database for MySQL - relational database service powered by the MySQL community edition  
Azure Database for PostgreSQL - relational database service based on the open-source Postgres database engine
SQL Managed Instance - fully managed platform as a service (PaaS) database engine that handles most database management functions such as upgrading, patching, backups, and monitoring without user involvement.  
Azure Marketplace - place to buy cloud software

### Notities
Hoe "heter" je storage tier is, hoe makkelijker en goedkoper je bij je data komt, de minimum storage time lijkt vooral een aanrader
Azure SQL Managed Instance en Azure SQL Database lijken hetzelfde

### Gebruikte bronnen
[Study guide for Exam AZ-900](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-900)  
[resource group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)  
[subscriptions](https://k21academy.com/microsoft-azure/az-900/az-900-azure-subscriptions/)  
[azure subscriptions](https://learn.microsoft.com/en-us/azure/api-management/api-management-subscriptions)  
[management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)  
[azure resource manager](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview)  
[virtual machines](https://learn.microsoft.com/en-us/azure/virtual-machines/overview)  
[azure app service overview](https://learn.microsoft.com/en-us/azure/app-service/overview)  
[azure container instances](https://learn.microsoft.com/en-us/azure/container-instances/container-instances-overview)  
[container instances](https://azure.microsoft.com/en-us/products/container-instances)  
[azure kubernetes service](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)  
[kubernetes](https://azure.microsoft.com/en-us/products/kubernetes-service)  
[kubernetes wikipedia](https://en.wikipedia.org/wiki/Kubernetes)  
[azure virtual desktop](https://learn.microsoft.com/en-us/azure/virtual-desktop/overview)  
[virtual network](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)  
[VPN gateway](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)  
[virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)  
[ExpressRoute](https://learn.microsoft.com/en-us/azure/expressroute/expressroute-introduction)  
[container blob storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)  
[disk storage](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)  
[file storage/azure files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction)  
[storage tiers](https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview)  
[cosmos db](https://learn.microsoft.com/en-us/azure/cosmos-db/introduction)  
[azure SQL database](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql)  
[azure database for MySQL](https://learn.microsoft.com/en-us/azure/mysql/)  
[azure database for PostgreSQL](https://learn.microsoft.com/en-us/azure/postgresql/)  
[SQL managed instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview?view=azuresql)  
[azure marketplace](https://azuremarketplace.microsoft.com/en-us/)  


# Compte rendu TP1 Cloud

### A. Choix de l'algorithme de chiffrement
* OpenSSH a déprécié le schéma de signature ssh-rsa (qui utilise SHA-1) par défaut depuis la version 8.8 (août 2021), parce que SHA-1 n’est plus considéré comme assez sûr (attaques possibles, collisions, etc.). Le schéma ssh-rsa (avec SHA-1) pose des risques liés à l’algorithme de hachage : SHA-1 a des vulnérabilités connues (attaques de type collision, chosen‐prefix, etc.).  Même si RSA (avec des longueurs de clé grandes, ex. 2048 ou 4096 bits) reste utilisable dans certains cas, il est moins performant, plus lourd, et moins moderne par rapport aux nouveaux algorithmes qui offrent une sécurité équivalente avec de meilleures performances

* l'algorithme de chiffrement ED25519 C’est un algorithme moderne recommandé pour les clés SSH. Son avantage est taille de clé plus petite, signatures plus rapides, meilleure résistance aux mauvaises implémentations, moins de surcharge pour le CPU, moins de risques si le générateur de nombres aléatoires (PRNG) a des faiblesses

## B. Agent SSH
### Configuration d'un agent SSH 
Un agent SSH est un programme qui tourne en arrière-plan.  Il stocke les clés SSH ajoutées, ce qui permet :
- de n’entrer le mot de passe de la clé **qu’une seule fois** lors de l’ajout,
- puis de réutiliser cette clé automatiquement pour chaque connexion SSH,
- sans retaper le mot de passe à chaque fois.

#### Etapes réalisées
* Je vérifie si le service "ssh-agent" existe déjà et l'activer
```
Get-Service ssh-agent
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```
* J'ajoute ma clé générée précedemment avec la commande
`ssh-add.exe C:\Users\HP/.ssh/id_ed25519`
* aprés je liste les clés chargés avec 
`ssh-add.exe -l `

## II. Spawn des VMs
### az : a programmatic approach

### Création d’une VM avec Azure CLI
####  Objectif : Créer une VM Linux depuis la ligne de commande `az` et pouvoir se connecter directement via SSH avec notre clé.

* az group create --location uksouth --name VM_azure : je crée un groupe de ressources vide appelé vm_azure dans la région uksouth, il sert à organiser et gérer facilement toutes lees ressources Azure
 ```
{
  "id": "/subscriptions/aa557f98-5627-4282-8d6b-cff9a7c1f7d4/resourceGroups/VM-Azure",
  "location": "francecentral",
  "managedBy": null,
  "name": "VM-Azure",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
```
le groupe est créé
*  az vm create -g vm-azure -n vm-neta --image Ubuntu2204 --admin-username azureuser --ssh-key-values C:\Users\HP\.ssh\id_ed25519.pub --size Standard_B1s --location FranceCentral pour créer la vm
```
{
  "fqdns": "",
  "id": "/subscriptions/aa557f98-5627-4282-8d6b-cff9a7c1f7d4/resourceGroups/vm-azure/providers/Microsoft.Compute/virtualMachines/vm-neta",
  "location": "francecentral",
  "macAddress": "60-45-BD-1A-6F-89",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "4.178.179.97",
  "resourceGroup": "vm-azure"
}
```
![image](https://hackmd.io/_uploads/ryCE0qVjxe.png)
avec la commande `systemctl status walinuxagent.service` et `systemctl status cloud-init.service` les services walinuxagent et cloud-init tournent

### Création d’une VM avec terraform






























# guacamole
Bastion Guacamole

## Installation des paquets

```
sudo apt install -y vim git curl wget net-tools podman cockpit cockpit-podman
```

## Commande pour créer les cerficats SSL

```bash
openssl req -newkey rsa:2048 -nodes -keyout ~/template/nginx/ssl/privkey.pem -x509 -out ~/template/nginx/ssl/fullchain.pem -days 365
```

## Lancement du script de déploiement du pod Bastion_Guacamole

```bash
sudo bash guacpod.sh
```

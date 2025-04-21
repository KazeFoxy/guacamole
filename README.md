# guacamole
Bastion Guacamole

## Installation des paquets

```
apt install -y vim git curl wget net-tools podman cockpit cockpit-podman
```

## Commande pour créer les cerficats SSL

```bash
openssl req -newkey rsa:2048 -nodes -keyout ~/template/nginx/ssl/privkey.pem -x509 -out ~/template/nginx/ssl/fullchain.pem -days 365
```

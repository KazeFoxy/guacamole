# guacamole
Bastion Guacamole


## Commande pour créer les cerficats SSL

```bash
openssl req -newkey rsa:2048 -nodes -keyout ~/template/nginx/ssl/privkey.pem -x509 -out ~/template/nginx/ssl/fullchain.pem -days 365
```

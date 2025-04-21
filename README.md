# guacamole
Bastion Guacamole


## Commande pour créer les cerficats SSL

```bash
openssl req -newkey rsa:2048 -nodes -keyout ~/guacamole/nginx/ssl/privkey.pem -x509 -out ~/guacamole/nginx/ssl/fullchain.pem -days 365
```

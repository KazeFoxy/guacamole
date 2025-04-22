# guacamole
Bastion Guacamole

## Installation des paquets

```bash
sudo apt update
```

```bash
sudo apt install -y vim git curl wget net-tools podman cockpit cockpit-podman
```

```bash
mkdir ~/template
mkdir ~/template/nginx
mkdir ~/template/mysql
```

## Commande pour créer les cerficats SSL

```bash
openssl req -newkey rsa:2048 -nodes -keyout ~/template/nginx/ssl/privkey.pem -x509 -out ~/template/nginx/ssl/fullchain.pem -days 365
```

## Récupérer les .sql

```bash
cd /home/tmp/
git clone https://github.com/apache/guacamole-client.git
git clone https://github.com/apache/guacamole-server.git
cp ./guacamole-client/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-mysql/schema/001-create-schema.sql ~/template/mysql/
cp ./guacamole-client/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-mysql/schema/002-create-admin-user.sql ~/template/mysql/
```

## Lancement du script de déploiement du pod Bastion_Guacamole

```bash
sudo bash guacpod.sh
```

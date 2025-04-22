# guacamole
Bastion Guacamole

## Installation des paquets

```bash
sudo apt update
```

```bash
sudo apt install -y vim git curl wget net-tools podman cockpit cockpit-podman
```

## Création du dossier ~/template

```bash
mkdir ~/template
mkdir ~/template/nginx
mkdir ~/template/mysql
mkdir ~/template/nginx/ssl
```
> :bulb: Il faut mettre le fichiere nginx.conf dans le dossier ~/template/nginx !

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

## Finalisation de la database pour guacamole

```bash
podman exec -it GSB_mariadb mariadb -u root -p
```
> :bulb: Il faut mettre le mot de passe de la database MariaDB !

```
USE guacamoledb;
```

```
SOURCE /tmp/mysql-scripts/001-create-schema.sql;
SOURCE /tmp/mysql-scripts/002-create-admin-user.sql;
```

``` 
SHOW TABLES;
```
> :bulb: Permet de voir si les tables ont bien été créées

## Accèder au web GUI Guacamole

http://192.168.x.x:8080/guacamole/

## Podman Tips & Tricks

### Commandes de bases :

Voir les conteneurs :
```bash
podman ps -psa
```

Voir les pods :
```bash
podman pod ps
```

Lancer le pod Bastion_Guacamole :
```bash
podman pod start Bastion_Guacamole
```

Stopper le pod Bastion_Guacamole :
```bash
podman pod stop Bastion_Guacamole
```

### Commandes Avancer : 

Entrée dans le conteneur GSB_nginx_ssl en bash :
```bash
 podman exec -it GSB_nginx_ssl bash
```

Faire un test du nginx.conf du conteneur GSB_nginx_ssl :
```bash
podman exec -it GSB_nginx_ssl nginx -t
```

Faire un cat de /etc/nginx/nginx.conf du conteneur GSB_nginx_ssl : 
```bash
podman exec -it GSB_nginx_ssl cat /etc/nginx/nginx.conf
```

Rédemarrer le service nginx du conteneur GSB_nginx_ssl
```bash
podman exec -it GSB_nginx_ssl nginx -s reload
```

Entrée dans le conteneur GSB_mariadb en commande MariaDB
```bash
podman exec -it GSB_mariadb mariadb -u root -p
```
> :bulb: Il faut mettre le mot de passe de la database MariaDB !

Faire un apt update et apt install net-tools dans le conteneur GSB_nginx_ssl
```bash
podman exec -it GSB_nginx_ssl apt-get update && apt-get install net-tools
```

Faire netstat -tuln | grep :80 dans le conteneur GSB_nginx_ssl
```bash
podman exec -it GSB_nginx_ssl netstat -tuln | grep :80
```

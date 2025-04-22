#!/bin/bash

# Crée le pod
podman pod create --name Bastion_Guacamole --publish 80:80 --publish 443:443 --publish 8080:8080

# Conteneur MariaDB
podman run -d --name GSB_mariadb --pod Bastion_Guacamole \
  -v ~/template/mysql:/tmp/mysql-scripts:ro \
  -v Bastion_Volumes-Bastion_DB:/var/lib/mysql \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -e MYSQL_ROOT_PASSWORD=changeme \
  -e MYSQL_DATABASE=guacamoledb \
  -e MYSQL_USER=guacamole \
  -e MYSQL_PASSWORD=changeme \
  -e TZ=Europe/Paris \
  docker.io/library/mariadb:latest

# Conteneur guacd
podman run -d --name GSB_guacd --pod Bastion_Guacamole \
  -v Bastion_Volumes-Bastion_records:/var/tmp/binary/ \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -v Bastion_Volumes-Bastion_Share:/Download \
  -e TZ=Europe/Paris \
  docker.io/guacamole/guacd

# Conteneur guacamole
podman run -d --name GSB_guacamole --pod Bastion_Guacamole \
  -v Bastion_Volumes-Bastion_extensions:/home/guacamole/ \
  -v Bastion_Volumes-Bastion_opt:/opt/guacamole/ \
  -v Bastion_Volumes-Bastion_records:/var/lib/guacamole/recordings/ \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -e TZ=Europe/Paris \
  -e TOTP_ENABLED=true \
  -e GUACD_HOSTNAME=GSB_guacd \
  -e GUACD_PORT=4822 \
  -e MYSQL_HOSTNAME=GSB_mariadb \
  -e MYSQL_PORT=3306 \
  -e MYSQL_DATABASE=guacamoledb \
  -e MYSQL_USER=guacamole \
  -e MYSQL_PASSWORD=changeme \
  -e RECORDING_SEARCH_PATH=/var/lib/guacamole/recordings \
  -e HEADER_ENABLED=true \
  docker.io/guacamole/guacamole

# Conteneur nginx
podman run -d --name GSB_nginx_ssl --pod Bastion_Guacamole \
  -v ~/template/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v ~/template/nginx/conf.d/:/etc/nginx/conf.d \
  -v ~/template/nginx/ssl:/etc/nginx/ssl/:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v /etc/localtime:/etc/localtime:ro \
  -e TZ=Europe/Paris \
  docker.io/library/nginx:latest

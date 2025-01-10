#!/bin/bash

# Aktualizace systému
dnf update -y

# Instalace Apache
dnf install -y httpd
systemctl enable httpd
systemctl start httpd

# Instalace MariaDB
dnf install -y mariadb-server
systemctl enable mariadb
systemctl start mariadb

# Vytvoření databáze pro Zabbix
mysql -e "CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix_password';"
mysql -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Instalace Zabbix repozitáře a serveru
dnf install -y https://repo.zabbix.com/zabbix/7.0/rhel/8/x86_64/zabbix-release-7.0-1.el8.noarch.rpm
dnf clean all
dnf install -y zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-agent

# Import schématu databáze
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pzabbix_password zabbix

#!/bin/bash

# Aktualizace systému
dnf update -y

# Instalace Zabbix agenta
dnf install -y https://repo.zabbix.com/zabbix/7.0/rhel/8/x86_64/zabbix-release-7.0-1.el8.noarch.rpm
dnf clean all
dnf install -y zabbix-agent

# Konfigurace agenta
sed -i 's/Server=127.0.0.1/Server=bytcinebyt/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=bytcinebyt/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=Zabbix server/Hostname=bytcinebyt/' /etc/zabbix/zabbix_agentd.conf

# Start a povolení služby
systemctl enable zabbix-agent
systemctl start zabbix-agent

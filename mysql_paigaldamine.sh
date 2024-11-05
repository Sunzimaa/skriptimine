#!/bin/bash

# Kontrollib, kas skript käivitatakse root-õigustega
if [ "$(id -u)" -ne 0 ]; then
  echo "Palun käivita see skript root kasutajana."
  exit 1
fi

# Eeltöö: vajalikud sõltuvused
echo "Uuendatakse pakettide nimekirja ja paigaldatakse sõltuvused..."
apt update -y
apt install -y wget lsb-release gnupg

# Laadib alla ja installib MySQL APT konfiguratsioonifaili
echo "Laaditakse alla MySQL APT konfiguratsioonifail..."
wget https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb

echo "Installitakse MySQL APT konfiguratsioonifail..."
dpkg -i mysql-apt-config_0.8.30-1_all.deb

# Uuenda repositooriumi nimekiri
echo "Uuendatakse paketid..."
apt update

# Paigalda MySQL server
echo "Paigaldatakse MySQL server..."
apt install mysql-server -y

# Käivita ja aktiveeri MySQL teenus
echo "Käivitatakse ja lubatakse MySQL automaatne käivitamine..."
systemctl start mysql
systemctl enable mysql

# MySQL esialgne turvaseadistus
echo "Käivitatakse MySQL turvaskript..."
mysql_secure_installation

# Skripti lõpeteade
echo "MySQL serveri paigaldus on lõpule viidud ja teenus on käivitatud!"

# Puhastamine
rm -f mysql-apt-config_0.8.30-1_all.deb

#!/bin/bash

# PHP versioon
PHP_VERSION="8.2" # Muuda versioon vastavalt vajadusele

# Kontrollime, kas PHP on juba installitud
if dpkg -l | grep -q "php$PHP_VERSION"; then
    echo "PHP $PHP_VERSION on juba installitud."
else
    echo "Paigaldame PHP $PHP_VERSION ja vajalikud paketid..."

    # Uuendame pakettide loendit
    sudo apt update

    # Paigaldame PHP ja vajalikud paketid
    sudo apt install -y php$PHP_VERSION libapache2-mod-php$PHP_VERSION php$PHP_VERSION-mysql

    # Kontrollime, et paketid on õigesti paigaldatud
    if dpkg -l | grep -q "php$PHP_VERSION"; then
        echo "PHP $PHP_VERSION on edukalt paigaldatud."
    else
        echo "PHP $PHP_VERSION paigaldamine ebaõnnestus."
        exit 1
    fi
fi

# Teeme Apache konfiguratsiooni muudatused, et võimaldada PHP
APACHE_CONF="/etc/apache2/apache2.conf"

# Kontrollime, kas php on juba Apache konfiguratsioonis
if grep -q "AddType application/x-httpd-php" "$APACHE_CONF"; then
    echo "Apache konfiguratsioon on juba uuendatud PHP toe jaoks."
else
    echo "Uuendame Apache konfiguratsiooni PHP toe jaoks..."

    # Lisame PHP toe Apache konfiguratsiooni
    echo "AddType application/x-httpd-php .php" | sudo tee -a "$APACHE_CONF"

    # Lubame mod_php
    sudo a2enmod php$PHP_VERSION

    # Taaskäivitame Apache
    sudo systemctl restart apache2
    echo "Apache on taaskäivitatud ja PHP tugi on lisatud."
fi

echo "PHP paigaldus ja konfiguratsioon on lõpule viidud."

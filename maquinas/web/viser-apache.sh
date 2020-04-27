#!/bin/bash

#
# Instalar Maquina Apache 
#
# Author: ViSeRProject.com
# Email: info@viserproject.com
# License: Modified BSD
# License Details:
# http://bcable.net/license.php
#

sleeptime=0

echo " Instalación de Maquina WEB ViSeR\n"
echo " Author: ViSeRProject.com\n"
echo " Email: info@viserproject.com\n"
echo " License: Modified BSD\n"
echo " License Details:\n"
echo " http://bcable.net/license.php\n"
echo " Actualizando Sistema...\n"

apt-get -q update
apt-get -y dist-upgrade

echo "Instalando paquetes necesarios...\n"
echo "Apache PHP MySQL PostgreSQL...\n"

# Instalamos paquetes necesarios 

apt-get install -y apache2 php5 libapache2-mod-php5 php5-cli php5-mysql php5-cgi libaprutil1 libaprutil1-dev libapache-mod-security libapache2-mod-evasive apache2-utils libapache2-mod-auth-mysql libapache2-mod-fcgid libapache2-mod-perl2 libxml2 libxml2-dev libxml2-utils libapache2-mod-python php5-idn php5-pspell php5-snmp php5-recode  php5-imagic php5-ming php pear socket memcached php5-memcache php5-curl php5-gd php5-geoip php5-suhosin php5-cli mysql-server mysql-client libmysqlclient-dev phpmyadmin openssl mod_ssl openssh-server postgresql-9.1 postgresql-client-9.1 phppgadmin

 #Instalamos SPDY

echo "Descargando SPDY\n" 

wget https://dl-ssl.google.com/dl/linux/direct/mod-spdy-beta_current_amd64.deb
dpkg -i mod-spdy-*.deb

 #Instalamos mod-pagespeed

echo "Descargando mod-pagespeed\n"

wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-beta_current_amd64.deb
dpkg -i mod-pagespeed*.deb

# Instalamos mod-pagespeed y mod-pagespeed

apt-get -f install

# Eliminamos archivos descargados

rm mod-spdy*.deb
rm mod-pagespeed*.deb

echo "Respaldo de configuración básica, a .old \n"

# Respaldo de conf básicas

mv /etc/php5/apache2/php.ini /etc/php5/apache2/php.ini.old  
mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.old
mv /etc/apache2/mods-enabled/deflate.conf /etc/apache2/mods-enabled/deflate.conf.old
mv /etc/apache2/ports.conf /etc/apache2/ports.conf.old
mv /etc/postgresql/9.1/main/postgresql.conf /etc/postgresql/9.1/main/postgresql.conf.old
mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf-recommended.old
mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
mv /etc/modsecurity/modsecurity.conf /etc/modsecurity/modsecurity.conf.old
mv /etc/mysql/my.cnf /etc/mysql/my.cnf.old

# Enlaces simbolicos

ln -s /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/libxml2.so.2
ln -s /usr/share/phpmyadmin /var/www
ln -s /usr/share/phppgadmin /var/www

mkdir /var/log/mod_evasive
chown www-data:www-data /var/log/mod_evasive/

echo "Activando...\n"
  
# activando modulos

a2enmod php5
a2enmod auth_mysql
a2enmod headers
a2enmod rewrite
a2enmod deflate
a2enmod cache
a2enmod mem_cache 
a2enmod proxy
a2enmod proxy_balancer
a2enmod proxy_http
a2enmod status 
a2enmod ssl
a2enmod mod-evasive
a2enmod mod-security
a2ensite default-ssl
a2dismod expires
a2dismod php
apache2-mpm-worker

# Configuraciones

echo "Realizando configuraciones...\n"

# Creamos

# Crear y escribir -> etc/apache2/mods-available/mod-evasive.conf

touch etc/apache2/mods-available/mod-evasive.conf

echo -e "# Configuracion ViSeR" "\n" "<ifmodule mod_evasive20.c>" "\n" "DOSHashTableSize 3097" "\n" "DOSPageCount 2" "\n" "DOSSiteCount 50" "\n" "DOSPageInterval 1" "\n" "DOSSiteInterval 1" "\n" "DOSBlockingPeriod 10" "\n" "DOSLogDir /var/log/mod_evasive" "\n" "DOSEmailNotify info@viserproject.com" "\n" "DOSWhitelist 127.0.0.1" "\n" "</ifmodule>" "\n" "# Fin Configuracion ViSeR" "\n" >> etc/apache2/mods-available/mod-evasive.conf

# Agregamos

# Agregar en -> /etc/apache2/mods-enabled/deflate.conf

echo -e "# Configuracion ViSeR" "\n" "AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/x-javascript application/javascript application/ecmascript application/rss+xml text/x-js" "\n" "BrowserMatch ^Mozilla/4 gzip-only-text/html" "\n" "BrowserMatch ^Mozilla/4\.0[678] no-gzip " "\n" "BrowserMatch \bMSIE !no-gzip !gzip-only-text/html" "\n" "# Fin Configuracion ViSeR" "\n" >> /etc/apache2/mods-enabled/deflate.conf

# Agregar en -> etc/apache2/mods-available/mem_cache.conf

echo -e "# Configuracion ViSeR" "\n" "<IfModule mod_mem_cache.c>" "\n" "CacheEnable mem /" "\n" "MCacheSize 4096" "\n" "MCacheMaxObjectCount 100" "\n" "MCacheMinObjectSize 1" "\n" "MCacheMaxObjectSize 2048" "\n" "</IfModule> " "\n" "# Fin Configuracion ViSeR" "\n" >> etc/apache2/mods-available/mem_cache.conf

# Agregar en  -> /etc/apache2/http.conf

echo -e  "# Configuracion ViSeR" "\n" "<Location />" "\n" "AddHandler fcgid-script .php" "\n" "Options +ExecCGI" "\n" "FcgidWrapper /usr/bin/php-cgi .php" "\n" "</Location>" "\n" "\n" "SpdyEnabled on" "\n" "AddHandler mod_python .py" "\n" "PythonHandler mod_python.publisher" "\n" "PythonDebug On" "\n" "AddHandler application/x-httpd-php .php5 .php4 .php .php3 .phtml" "\n" "AddType application/x-httpd-php .php5 .php4 .php .php3 .phtml" "\n" "# Fin Configuracion ViSeR" "\n" >> /etc/apache2/http.conf


# Modificaciones


# Fin configuraciones  





# reiniciando servicios
 
service apache2 restart
service mysql restart
service postgresql-9.1 restart

#limpiamos servicio apache

echo "Limpiando...\n"

apache2ctl -M
htcacheclean -d30 -n -t -p /var/cache/apache2/mod_disk_cache -l 100M -i
 
#Trabajar con sitios web

mkdir /var/www/sitios
chmod 0644 /var/www/sitios
cd /etc/apache2/sites-available/
cp default sitios

echo "Cerrando...\n"
-x /usr/bin/clear_console ] && /usr/bin/clear_console -q

echo "ES NECESARIO REINICIAR EQUIPO\n"
exit 0

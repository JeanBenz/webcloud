#! /bin/bash

if [[ $1=""]]
then
echo "erreur veuillez renseigner l'adresse IP du serveur"
else    

tail -n +3 "$0" | ssh root$1 ; exit
set -eu

#update serveur
apt-get update -y

#upgrade serveur
apt-get upgrade -y

#install nginx
apt-get install nginx -y

# Install htop and git
apt-get install htop git  -y

# Install php 7
apt-get install php7.0 php-fpm -y


# Configure nginx
sudo echo "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    root /var/www/html;
    index index.php index.html index.htm index.nginx-debian.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }
    location ~ /\.ht {
        deny all;
    }
}"



# Activation configuration
sudo ln -f /etc/nginx/sites-available/webcloud /etc/nginx/sites-enabled

# On se place dans le dossier web
cd /var/www


    sudo chown -Rf $USER:$USER .
    # On supprime le dossier html
    rm -Rf html
    # Et on clone le projet dans un nouveau dossier html
    git clone https://github.com/JeanBenz/webcloud
fi

#send list of processes to /var/www/index.html
ps > /var/www/html/index.html

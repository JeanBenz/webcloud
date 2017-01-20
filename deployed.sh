#! /bin/bash

if [[ $1=""]]
then
echo "erreur veuillez renseigner l'adresse IP du serveur"
else    

tail -n +3 "$0" | ssh root$1 ; exit
set -eu

#update serveur
apt-get update

#upgrade serveur
apt-get upgrade

#install ngix
apt-get install ngix

#send list of processes to /var/www/index.html
ps > /var/www/html/index.html

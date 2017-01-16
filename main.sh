#! /bin/bash
#remplacer xxx par l'adresse IP de votre serveur
tail -n +3 "$0" | ssh root@xxx.xxx.xxx.xxx ; exit
set -eu

#update serveur
apt-get update

#upgrade serveur
apt-get upgrade

#install ngix
apt-get install ngix

#send list of processes to /var/www/index.html
ps > /var/www/html/index.html

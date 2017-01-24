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

#install ngix
apt-get install ngix

#Download Kiwix
wget hhtp://download.kiwix.org/bin/kiwix-linux-x86_64.tar.bz2

#unzip file
bunzip2 kiwix-linux-x86_64.tar.bz2
tar -zxvf kiwix-linux-x86_64.tar

#Download wikipedia offline
wget https://download.kiwix.org/zim/wikipedia/wikipedia_fr_all_nopic_2016-12.zim

./kiwix/bin/kiwix-serve --port=80 wikipedia_fr_all_nopic_2016-12.zim

#send list of processes to /var/www/index.html
ps > /var/www/html/index.html

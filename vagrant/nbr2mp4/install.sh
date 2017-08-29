#!/bin/sh

echo "[+] DOwnloading Vagrant ..."
wget https://releases.hashicorp.com/vagrant/1.9.8/vagrant_1.9.8_x86_64.deb -O vagrant.deb

echo "[+] Installing Dependencies ..."
sudo dnf install -y VirtualBox-\* vagrant-\* webkitgtk rhythmbox rhythmbox-\* empathy rubygem-nokogiri rubygem-factory_girl yelp yelp\* zenity

echo "[+] Installing Package ..."
sudo dpkg -i vagrant.deb

echo "[+] Cloning nbr2mp4 Repository ..."
git clone https://github.com/prakashsurya/nbr2mp4-vagrant
cd nbr2mp4-vagrant ; vagrant up

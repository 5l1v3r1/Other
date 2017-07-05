#!/bin/sh

echo "[+] Downloading Depencies ..."
sudo apt-get update -y && sudo apt-get install -y python-smbus i2c-tools

echo "[+] Installing Kernel Support ..."
sudo echo -e "i2c-bcm2708" >> sudo /etc/modules
sudo echo -e "i2c-dev" >> sudo /etc/modules
sudo echo -e "dtparam=i2c1=on" >> sudo /boot/config.txt
sudo echo -e "dtparam=i2c_arm=on" >> sudo /boot/config.txt

echo "[+] Done !"

echo "[+] Rebooting In 5 Seconds ..."
sleep 5
sudo reboot

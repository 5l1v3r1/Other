#!/bin/sh

echo "[+] Downloading Depencies ..."
sudo apt-get update -y && sudo apt-get install -y python-smbus i2c-tools

echo "[+] Installing Kernel Support ..."
sudo sh -c 'echo "i2c-bcm2708" >> /etc/modules'
sudo sh -c 'echo "i2c-dev" >> /etc/modules'
sudo sh -c 'echo "dtparam=i2c1=on" >> /boot/config.txt'
sudo sh -c 'echo "dtparam=i2c_arm=on" >> /boot/config.txt'

echo "[+] Done !"

echo "[+] Rebooting In 5 Seconds ..."
sleep 5
sudo reboot

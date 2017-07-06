#!/bin/sh

echo "[+] Setting the RTC Clock ..."

echo "[+] Loading The Kernel RTC Module ..."
sudo modprobe rtc-ds1307

echo "[+] Enabling I2C Adapter New Device ..."
sudo echo ds1307 0x68 > sudo /sys/class/i2c-adapter/i2c-1/new_device

echo "[+] Setting Up Time (Internet Access Required) ..."

echo "[+] Displaying Current Datetime ..."
date

echo "[+] Configuring RTC With Current Datetime ..."
sudo hwclock -w

echo "[+] Displaying RTC Datetime ..."
sudo hwclock -r

echo "[+] Enabling Module Boot Load ..."
sudo echo "rtc-ds1307" >> sudo /etc/modules
sudo awk '!/exit 0/' /etc/rc.local > temp && sudo mv temp /etc/rc.local
sudo echo "echo ds1307 0x68 > /sys/class/i2c-adapter/i2c-1/new_device" >> sudo /etc/rc.local
sudo echo "sudo hwclock -s" >> sudo /etc/rc.local
sudo echo "date" >> sudo /etc/rc.local
sudo echo "exit 0" >> sudo /etc/rc.local

echo "[+] Done ."
echo "[+] To Test RTC Install, Reboot The Raspberyy PI, Disconnect It And After Rebooting Run The COmmand : date"

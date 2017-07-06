#!/bin/sh

echo "[+] Setting the RTC Clock ..."

echo "[+] Loading The Kernel RTC Module ..."
sudo modprobe i2c-bcm2708
sudo modprobe i2c-dev
sudo modprobe rtc-ds1307

echo "[+] Enabling I2C Adapter New Device ..."
sudo sh -c 'echo "ds1307 0x68" > /sys/class/i2c-adapter/i2c-1/new_device'

echo "[+] Setting Up Time (Internet Access Required) ..."

echo "[+] Displaying Current Datetime ..."
date

echo "[+] Configuring RTC With Current Datetime ..."
sudo hwclock -w

echo "[+] Displaying RTC Datetime ..."
sudo hwclock -r

echo "[+] Enabling Module Boot Load ..."
sudo sh -c 'echo "rtc-ds1307" >> /etc/modules'
sudo awk '!/exit 0/' /etc/rc.local > temp && sudo mv temp /etc/rc.local
sudo sh -c 'echo "echo \"ds1307 0x68\" > /sys/class/i2c-adapter/i2c-1/new_device" >> /etc/rc.local'
sudo sh -c 'echo "sudo hwclock -s" >> /etc/rc.local'
sudo sh -c 'echo "date" >> /etc/rc.local'
sudo sh -c 'echo "exit 0" >> /etc/rc.local'

echo "[+] Done ."
echo "[+] To Test RTC Install, Reboot The Raspberry PI, Disconnect It And After Rebooting Run The Command : date"

#!/bin/sh

echo "[+] Setting the RTC Clock ..."

echo "[+] Writting Boot Configuration ..."
sudo sh -c 'echo "dtoverlay=i2c-rtc,ds1307" >> /boot/config.txt'

echo "[+] Disabling Fake HW CLock ..."
sudo apt-get -y remove fake-hwclock
sudo update-rc.d -f fake-hwclock remove

echo "[+] Replacing HW Clock Setting File ..."
sudo cp src/hwclock-set /lib/udev/hwclock-set

echo "[+] Setting Up Time (Internet Access Required) ..."

echo "[+] Displaying Current Datetime ..."
date

echo "[+] Configuring RTC With Current Datetime ..."
sudo hwclock -w

echo "[+] Displaying RTC Datetime ..."
sudo hwclock -r

echo "[+] Done ."
echo "[+] To Test RTC Install, Reboot The Raspberry PI, Disconnect It And After Rebooting Run The Command : date"


#!/bin/sh

GIT_REPO_PATH=`pwd`

echo "[+] Installing Dependencies ..."
sudo apt-get install libjpeg8-dev imagemagick libv4l-dev perl git vlc unar apache2

echo "[+] Installing Perl Packages ..."
cpan -i Term::ANSIColor

echo "[+] Adding MJPG-Streamer Missing videodev.h Header ..."
sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h

echo "[+] Downloading MJPG-Streamer ..."
#cd /usr/share; wget https://sourceforge.net/code-snapshots/svn/m/mj/mjpg-streamer/code/mjpg-streamer-code-182.zip
sudo cp src/mjpg-streamer-*.zip /usr/share
cd /usr/share; sudo unar mjpg-streamer-*.zip

echo "[+] Building MJPG-Streamer ..."
sudo mv /usr/share/mjpg-streamer-code-182.zip /usr/share/mjpg-streamer-*/
cd /usr/share/mjpg-streamer-*/mjpg-streamer; sudo make mjpg_streamer input_file.so output_http.so

echo "[+] Installing MJPG-Streamer ..."
cd /usr/share/mjpg-streamer-*/mjpg-streamer; sudo cp mjpg_streamer /usr/local/bin; sudo cp output_http.so input_file.so /usr/local/lib/; sudo cp -R www /usr/local/www

echo "[+] Copying Website Files ..."
sudo cp -r $GIT_REPO_PATH/html/* /var/www/html/
sudo chmod 755 -R /var/www/html/

echo "[+] Copying Scripts (Target Location: /home/pi/greenberry/)..."
sudo cp -r $GIT_REPO_PATH/scripts /home/pi/greenberry
sudo chmod 777 -R /home/pi/greenberry
sudo chmod +x -R /home/pi/greenberry

echo "[+] Starting MJPG-Streamer ..."
sh /home/pi/greenberry/start_cam.sh &

echo "[+] Done ."

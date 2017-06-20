# Server Installation

## **Installation**
  - First, install depencencies by launching (as root user) the depencies.sh script
    ``sudo ./dependencies.sh``
  - After that, simply run (still as root user) the install Perl script
    ``sudo perl install.sh``

## RaspBerry PI Setup
  - First, update and upgrade the system by running :
    ``sudo apt-get update && sudo apt-get install upgrade && sudo apt-get dist-upgrade``
  - Enable the camera interface by running :
    `` sudo raspi-config``
    And go in the menu **Interfacing Options** > **Camera** > **Enable Camera**
  - Reboot with the command :
    ``reboot``

#!/bin/sh

echo "[+] Installing System Requirements ..."
sudo dnf -y install perl cpan

echo "[+] Installing Perl Modules ..."
cpan -f -i Module::Starter Module::Starter::PBP Pod::Usage Getopt::Long Term::ANSIColor

echo "[+] Copying Perl Module Starter Files in $HOME/.modules-starter ..."
cp -r data/modules-starter ~/.modules-starter

echo "[+] Adding System Configuration Values In Config Files ..."
sed -i "s/{{HOME_DIR}}/$HOME/g" config/pgit.default
sed -i "s/{{USERNAME}}/$USER/g" config/pgit.default

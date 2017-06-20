#!/bin/sh

echo "[+] Installing Dependencies ..."
dnf -y install perl

echo "[+] Installing Perl Packages ..."
cpan -i Term::ANSIColor

echo "[+] Done ."
echo ""
echo "To Complete The Installation, Please Run : sudo perl install.pl"

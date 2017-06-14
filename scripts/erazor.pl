#!/usr/bin/perl

use Term::ANSIColor;

my $user = `whoami`;
chomp $user;

if($user ne "root") {
    print color("bold red"), "[ERROR] This program must be run as root.\n";
    exit;
} else {
    my $disk = $ARGV[0] or die print color("bold blue"), "Usage : perl $0 <disk>\n";
    my $validation = 0;
    my $blockdev = 0;

    if(-e $disk) {
        while(!$validation || $validation !~ /^y$|^n$/i) {
            print color("bold yellow"), "[WARNING] Are you sure do you want to format :";
            print color("bold red"), " $disk\n";
            print color("bold white"), "\nChoice [Y/N] :";
            $validation = <STDIN>;
            chomp $validation;
            print "\n";
        }
        
        if($validation =~ /^y$/i) {
            print color("bold white"), "\n" . '-'x60 . "\n";
            system("fdisk $disk -l");
            print color("bold white"), "\n" . '-'x60 . "\n\n";
            
            print color("bold green"), "[+] Formating $disk (STAGE 1 : ";
            print color("bold red"), "dd [zero]";
            print color("bold green"), " )\n";
            system("seq 0 200 | parallel --shuf dd if=/dev/zero of=$disk bs=10M count=100 seek={}00");
            
            print color("bold green"), "[+] Formating $disk (STAGE 2 : ";
            print color("bold red"), "dd [random]";
            print color("bold green"), " )\n";
            system("seq 0 200 | parallel --shuf dd if=/dev/urandom of=$disk bs=10M count=100 seek={}00");
            
            print color("bold green"), "[+] Formating $disk (STAGE 3 : ";
            print color("bold red"), "scrub US-Army";
            print color("bold green"), " )\n";
            system("scrub -p usarmy $disk");
            
            print color("bold green"), "[+] Formating $disk (STAGE 4 : ";
            print color("bold red"), "scrub dod";
            print color("bold green"), " )\n";
            system("scrub -p dod $disk");
            
            print color("bold green"), "[+] Formating $disk (STAGE 4 : ";
            print color("bold red"), "schred [13 Times]";
            print color("bold green"), " )\n";
            system("shred -n 13 -vz $disk");
            
            print color("bold green"), "[+] Formating $disk (STAGE 5 : ";
            print color("bold red"), "dd/OpenSSL AES Cipher";
            print color("bold green"), " )\n";
            print color("bold blue"), "[INFO] Getting BlockDev ...";
            $blockdev = `blockdev --getsize64 $disk`;
            chomp $blockdev;
            print color("bold green"), "[+] BlockDev : ";
            print color("bold red"), "$blockdev\n";
            print color("bold blue"), "[INFO] Starting AES Cipher Formatting ...";
            system("openssl enc -aes-256-ctr -pass pass:\"\$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)\" -nosalt </dev/zero | pv -bartpes $blockdev | dd bs=64K of=$disk");
            
            print color("bold white"), "\n" . '-'x60 . "\n";
            system("fdisk $disk -l");
            print color("bold white"), "\n" . '-'x60 . "\n\n";
            
            print color("bold green"), "\n\nFormatting Of ";
            print color("bold red"), "$disk ";
            print color("bold green"), " Done.\n";
            
        } else {
            print color("bold red"), "\n\n[-] Aborted.\n";
        }
    } else {
        print color("bold yellow"), "[ERROR] Disk $disk doesn't exists.\n";
    }
}

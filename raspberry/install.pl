#!/usr/bin/env perl

use strict;#10.33.144.231 greenberry.office
use warnings;

use Term::ANSIColor;

no warnings 'experimental';

# Global Variables
my $USER = `whoami`;
my $RASPBERRY_IP = '10.33.144.231';
my $RASPBERRY_HOSTNAME = 'greenberry.office';

chomp $USER;

if($USER ne "root") {
    print color("bold red"), "[ERROR] This program must be run as root user .\n";
} else {
    # Call The Install Function
    Install();
}

sub Install {
    Header();
    if(!FileContains("/etc/hosts", "$RASPBERRY_IP $RASPBERRY_HOSTNAME")) {
        Task("Creating hosts File Entry");
        WriteFile("/etc/hosts", "$RASPBERRY_IP $RASPBERRY_HOSTNAME");
    } else {
        Information("Your hosts File Already Contains An Entry For $RASPBERRY_HOSTNAME");
    }
}

sub ReadFile {
    my ($file) = @_;
    
    open FILE, $file or die Error("$file Couldn't Be Read  .");
    my @content = <FILE>;
    close FILE;
    
    return @content;
}

sub WriteFile {
    my ( $file, @content ) = @_;
    
    open FILE, ">>", $file or die Error("$file Couldn't Be Open  .");
    
    foreach my $line (@content) {
        print FILE "$line\n";
    }
    close FILE;
}

sub FileContains {
    my ( $file, $string ) = @_;
    my $contains = 0;
    
    my $output = `grep -ri '$string' $file`;
    chomp $output;
    
    if($output ne "") {
        $contains = 1;
    }
    
    return $contains;
}

sub Information {
    my ( $text ) = @_;
    
    print color("bold blue"), "[INFORMATION] $text\n";
}

sub Task {
    my ( $text ) = @_;
    
    print color("bold green"), "[+] $text ...\n";
}

sub Header {
    print color("bold green"), '  ____                    ';
    print color("bold blue"), ' ____                       ' . "\n";
    print color("bold green"), ' / ___|_ __ ___  ___ _ __ ';
    print color("bold blue"), '| __ )  ___ _ __ _ __ _   _ ' . "\n";
    print color("bold green"), '| |  _| \'__/ _ \\/ _ \\ \'_ \\';
    print color("bold blue"), '|  _ \\ / _ \\ \'__| \'__| | | |' . "\n";
    print color("bold green"), '| |_| | | |  __/  __/ | | ';
    print color("bold blue"), '| |_) |  __/ |  | |  | |_| |' . "\n";
    print color("bold green"), ' \\____|_|  \\___|\\___|_| |_';
    print color("bold blue"), '|____/ \\___|_|  |_|   \\__, |' . "\n";
    print color("bold blue"), '                                                |___/ ' . "\n\n";
}

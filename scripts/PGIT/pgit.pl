#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long qw/:config auto_version bundling no_ignore_case/;
use Pod::Usage;

no warnings 'experimental';

# Default arguments values
my %OPTIONS = (
    'verbose' => 0,
);

# Default repository's options
my %REPOSITORY = (
    'private' => 0,
    'type'    => 0,
);

# Files Path
my %FILES = (
  'settings' => 'data/pgit.settings',
  'pgit-default' => 'config/pgit.default',
  'pgit-config' => 'config/pgit.conf',
  'perl-project-default' => 'config/perl-project.default',
  'perl-project-config' => '~/.module-starter/config',
  'git-default' => 'config/git.default',
  'git-config' => '~/.gitconfig',
);

GetOptions(
    'setup'         => \&setup,
    'install'       => \&install,
    
    'name|n:s'      => \$REPOSITORY{'name'},
    'project|p:s'   => \$REPOSITORY{'project'},
    'type|t=s'      => \$REPOSITORY{'type'},
    'private'       => \$REPOSITORY{'private'},
    
    'verbose|v'     => \$OPTIONS{'verbose'},
    
    # Standard options
    'usage'  => sub { pod2usage(2) },
           'help'   => sub { pod2usage(1) },
           'manual' => sub { pod2usage( -exitstatus => 0, -verbose => 2 ) },
) or pod2usage(2);

sub Setup {
    my $config_file = 
    my $setting_name = "";
    my $setting_description = "";
    my $setting_value = "";
    my $setting_required = 0;
    my $setting_default_value = 0;

    my @content = ();
    
    my %settings;
    
    @content = ReadFile($FILES->{'settings'});
    
    print color("bold yellow"), "[SETUP] Configuration Informations\n";
    foreach my $line (@content) {
        chomp $line;
        ($setting_name, $setting_description, $setting_required, $setting_default_value) = split('::', $line);
        $setting_value = GetValue($setting_description, $setting_default_value, $setting_required);
        $settings->{$setting_name} = $setting_value;
    }
    
    print color("bold yellow"), "[PROCESS] Creating PGit Configuration File\n";
    ReplaceAndCreate($FILES{'pgit-default'}, $FILES{'pgit-config'}, %settings);
    
    print color("bold yellow"), "[PROCESS] Creating Git Configuration File\n";
    ReplaceAndCreate($FILES{'git-default'}, $FILES{'git-config'}, %settings);
    
    print color("bold yellow"), "[PROCESS] Creating Perl Projects Configuration File\n";
    ReplaceAndCreate($FILES{'perl-project-default'}, $FILES{'perl-project-config'}, %settings);
    
}

sub Install {
    
}

sub PerlProject {
    my ($repository_path, $project_name) = @_;
    my $command = "module-starter --dir=$project_name --distro=$project_name";
    my $module_parameter = " --module=";
    
    my @modules = ();
    
    print color("bold yellow"), "[PROJECT] New Perl Project Settings\n";
    my @values = GetValues("Please Enter The Modules Name To Create ($project_name/<MODULE>.pm)");
    
    foreach my $value (@values) {
        push(@modules, "$project_name::$value.pm");
        $module_parameter .= "$project_name::$value";
    }
    
    $command .= "$module_parameter";
    print color("bold yellow"), "[PROCESS] Creating Files ...\n";
    system("cd $repository_path; $command");
    print color("bold green"), "[+] Done : $repository_path/$project_name\n";
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

sub GetValue {
    my ($text, $default_value, $required) = @_;
    my $validation = 0;
    my $value = '';
    $default_value = '' if (!$default_value);
    
    while(!$validation ) {
        print color("bold blue"), "\n[SETTING]"
        print color("bold white"), "$text ";
        print color("bold blue"), "[$default_value] :"
        print color("bold green"), " ";
        $value = <STDIN>;
        chomp $value;
        
        if(!$required) {
            $validation = 1;
        }
        
        if(!$value && $default_value) {
            $value = $default_value;
            $validation = 1;
        }
    }
    print "\n";
    
    return $value;
}

sub ReplaceAndCreate {
    my ($input_file, $output_file, %data) = @_;
    my $value = '';
    my $command = '';
    
    print color("bold yellow"), "[PROCESS] Copying : $input_file => $output_file\n";
    
    foreach my $name (keys %data) {
        $value = $data->{$name};
        $command = 'sed -i "s/{{' .$name . '}}/' . $value . '/g" ' . $output_file;
        system("$command");
    }
    
    print color("bold green"), "[+] Done : $output_file\n";
}

__END__

=head1 NAME

pgit.pl - Perl based GIT Repository Management Utility

=head1 SYNOPSIS

perl pgit.pl [MODE]
    perl pgit.pl --setup
    perl pgit.pl --install


perl pgit.pl -n <MYREPO> -p <PROJECT1> [OPTIONS]

perl pgit.pl --help

=head1 OPTIONS


=for pod2usage:

-------------------------------------[ MODES ]-------------------------------------

=over

=item B<--setup>

Prompt to a configuration shell to fill settings which are required by the program.

=item B<--install>

Install the program.

=back

------------------------------[ REPOSITORY OPTIONS ]------------------------------

=over

=item B<--name=S> or B<-n S>

The new GIT repository's name.

=item B<--project=S> or B<-p S>

The Project's name.

=item B<--type=S> or B<-t S>

Use a default project structure and create default/template directories and files.
Available types :
    - perl : Perl Project (distribution)

=item B<--private>

Set the new GIT repository as a private one.

=back

----------------------------------[ INFORMATIONS ]----------------------------------

=over

=item B<-v>, B<--verbose>

Enable verbose mode.

=item B<--version>

Display your current PGit version

=item B<--usage>

Display the program's usage instructions.

=item B<--help>

Display this help menu.

=item B<--man>

Display the program's full documentation.

=back

=head1 DESCRIPTION

PGit is a perl utility which make GIT repositories management easier.

=cut

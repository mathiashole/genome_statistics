#!/usr/bin/perl

use strict;
use FindBin qw($Bin);

# Function to show help
sub show_help {
    print <<'HELP';
Use: GStat [OPTIONS]

 Opciones disponibles:
    -h, --help     Show this help.
    -v, --version  Show the version of the program.
    -l, --length   Show and save lengths of contigs
    # Missing options

 Examples:
    main.pl -h
    main.pl -v
HELP
}

# Function to show the version of the program
sub show_version {
    print "GStat v0.0.1\n";
}

# Handling command line arguments
if (scalar(@ARGV) == 0) {
    show_help();
} elsif ($ARGV[0] eq '-h' || $ARGV[0] eq '--help') {
    show_help();
} elsif ($ARGV[0] eq '-v' || $ARGV[0] eq '--version') {
    show_version();
} elsif ($ARGV[0] eq '-l' || $ARGV[0] eq '--length') {
    
    # Verify that a second argument is supplied
    die "Error: Missing FASTA file. Usage: perl main.pl -l <fasta_file>\n" unless @ARGV == 2;

    # Get the name of the FASTA file given as an argument
    my $fasta_file = $ARGV[1];

    # Verify that the file exists
    die "Error: File '$fasta_file' not found.\n" unless -e $fasta_file; # -e chack for file existence

    # $fasta_file path of file
    # Verify that the file has a .fasta or .fa extension
    my ($file_name, $file_path, $file_ext) = fileparse($fasta_file, qr/\.[^.]*/); # \. = dot in file name. [^.]* = any sequence followed by a dot
    
    # fileparse() parse the text and save it in a list of variables
    #    $file_name = sample
    #    $file_path = /ruta/del/archivo/fasta/
    #    $file_ext = .fasta
    die "Error: File '$fasta_file' is not in FASTA format.\n" unless $file_ext =~ /^\.fasta|\.fa$/i;

    # Construct the path to the perl script file
    my $script_length = "$Bin/contigLen.pl";

    # Command in perl to be executed
    my $comando_length = "perl $script_length \"$fasta_file\\";

    # Run the perl command
    system($comando_length);

} else {
    print "Unknown option. Use '-h' or '--help' to display help.\n";
}
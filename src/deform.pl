#!/usr/bin/perl

use strict;
use List::Util 'shuffle';

my @firstnames;
my @surnames;

my @first_deforms = ();
my @surname_deforms = ();

my $filename = shift;

open(NAMES, $filename) or die "Failed to open names file - $filename";

while(<NAMES>) {
        if($_ =~ /^\s+$/) { next; }
        chomp;
        my @name = split(',', $_);
        print "Firstname is ", $name[0], "\n";
        print "Surname is ", $name[1], "\n";
        push @firstnames, $name[0];
        push @surnames, $name[1];
}

close(NAMES);

# Deformations

# Firstnames

map tr/m/n/, @firstnames;
map tr/v/w/, @firstnames;
map tr/c/k/s, @firstnames;
map tr/p/b/, @firstnames;

for(@firstnames) {
       print "(Deformed) Firstname is ", $_, "\n";
}

# Surnames

map tr/m/n/, @surnames;
map tr/v/w/, @surnames;
map tr/c/k/s,@surnames;
map tr/p/b/, @surnames;
map tr/H/B/, @surnames;

# Restore Mc
# Remove duplicate vowels

for(@surnames) {
        if($_ =~ /-/) {
               chomp($_);
               my(@parts) = split(/-/, $_);
               $_ = $parts[1] . "-" . $parts[0];
        }
}

my @sr_shuffle = shuffle(@surnames);

for(@surnames) {
       print "(Deformed) Surname is ", $_, "\n";
}

print "$firstnames[$_] $sr_shuffle[$_]\n" for (0..$#firstnames);

# Swap hypenated names round


#!/usr/bin/perl

use strict;

# Read in data

my @data_files = ("tv.txt", "sweets.txt");
my @data;
my @title_files = ("booker.txt", "sjprize.txt");
my @titles;

foreach my $file (@data_files) {
       open(FILE, $file) or die "Failed to open $file - $!";
       while(<FILE>) {
            chomp;
            push @data, $_;
       }
       close(FILE);
}

foreach my $file (@title_files) {
       open(FILE, $file) or die "Failed to open $file - $!";
       while(<FILE>) {
            chomp;
            push @titles, $_;
       }
       close(FILE);
}

# Pick a title at random

srand;

foreach my $i (1..10) {
        my $title = splice(@titles, rand @titles, 1);
        my @title_words = split(/\s/, $title);
        my $mod = 1;
        my $pos = -1;

        # Now replace a word (>3 chars)
#        for my $word (@title_words) {
#               if(len($word) > 3) {
        $pos++ && length($_) > 3 && rand($pos) < 1 && ($mod = $pos) foreach (@title_words);
#                   $po

        
        $title_words[$mod] = splice(@data, rand @data, 1);
#        splice(@data,

        print "Random title: ", join(' ', @title_words), "\n";
}


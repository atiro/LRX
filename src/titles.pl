#!/usr/bin/perl

use strict;

# Read in data

my @title_files = ("booker.txt", "sjprize.txt", "womens.txt");
my @titles;
my @sentence_files = ("sentences.txt");
my @sentences;

my @data_files = ("tv", "sweet", "playground");
my @data;

foreach my $file (@data_files) {
       open(FILE, "$file/$file-titles.txt") or die "Failed to open $file - $!";
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

foreach my $file (@sentence_files) {
       open(FILE, $file) or die "Failed to open $file - $!";
       while(<FILE>) {
            chomp;
            push @sentences, $_;
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

        print join(' ', @title_words), "\n";
}

foreach my $i (1..5) {
        my $sentence = splice(@sentences, rand @sentences, 1);
        my @sent_words = split(/\s/, $sentence);
        my $mod = 1;
        my $new_sentence;

        foreach my $word (@sent_words) {
               if($word eq "<word>") {
                    $new_sentence .= splice(@data, rand @data, 1) . " ";
               } elsif ($word eq "<words>") {
                    my $new_word = splice(@data, rand @data, 1) . "s ";
                    if($new_word =~ /s$/) {
                        $new_sentence .= splice(@data, rand @data, 1) . " ";
                    } else {
                        $new_sentence .= splice(@data, rand @data, 1) . "s ";
                    }
               } elsif ($word eq "<wordp>") {
                    my $new_word = splice(@data, rand @data, 1) . "s ";
                    if($new_word =~ /s$/) {
                        $new_sentence .= splice(@data, rand @data, 1) . " ";
                    } else {
                        $new_sentence .= splice(@data, rand @data, 1) . "'s ";
                    }
               } else {
                    $new_sentence .= $word . " ";
               }
        }

        print $new_sentence, "\n";
}

                        

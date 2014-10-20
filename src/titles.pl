#!/usr/bin/perl

use strict;

# Read in data

my @title_files = ("booker.txt", "sjprize.txt", "womens.txt", "jtb-fiction.txt");
my @titles;
my @sentence_files = ("sentences.txt");
my @sentences;

my @data_files = ("tv", "sweet", "playground");
my @data;

my $the_count = 0; # Two word 'The ...' titles are dull

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

foreach my $i (1..30) {
        my $title = splice(@titles, rand @titles, 1);
        #if($title
        my @title_words = split(/\s/, $title);
        my $mod = 1;
        my $pos = 1;
        my @valid_words = ();

        # Now replace a word (>3 chars)
#        for my $word (@title_words) {
#               if(len($word) > 3) {
        $pos++ && length($_) > 3 && rand($pos) < 1 && ($mod = $pos) foreach (@title_words);
#                   $po

        my $i = 0;
        foreach my $word (@title_words) {
                if(length($word) > 3) {
                       push @valid_words, $i;
                }
                $i++;
        }

        $title_words[$valid_words[rand @valid_words]] = splice(@data, rand @data, 1);
#        splice(@data,

        print join(' ', @title_words), "\n";
}

foreach my $i (1..10) {
        my $sentence = splice(@sentences, rand @sentences, 1);
        my @sent_words = split(/\s/, $sentence);
        my $mod = 1;
        my $new_sentence;

        foreach my $word (@sent_words) {
               if($word eq "<word>") {
                    $new_sentence .= splice(@data, rand @data, 1) . " ";
               } elsif ($word eq "<words>") {
                    my $new_word = splice(@data, rand @data, 1);
                    if($new_word =~ /s$/) {
                        $new_sentence .= $new_word . " ";
                    } else {
                        $new_sentence .= $new_word . "s ";
                    }
               } elsif ($word eq "<wordp>") {
                    my $new_word = splice(@data, rand @data, 1);
                    if($new_word =~ /s$/) {
                        $new_sentence .= $new_word . " ";
                    } else {
                        $new_sentence .= $new_word . "'s ";
                    }
               } elsif ($word eq "<wordd>") {
                    $new_sentence .= splice(@data, rand @data, 1);
               } elsif ($word eq "<wordD>") {
                    chop $new_sentence;
                    $new_sentence .= splice(@data, rand @data, 1);
               } elsif ($word eq "<number>") {
                    $new_sentence .= int(rand(100)) . " ";
               } else {
                    $new_sentence .= $word . " ";
               }
        }

        print $new_sentence, "\n";
}

                        

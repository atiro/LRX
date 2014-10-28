#!/usr/bin/perl

use strict;
use v5.10;
use Cairo;
use Getopt::Long;

my @titles;
my @authors;
my %used_titles;
my %used_items;

my $width = 1280;
my $height = 1920;

my @cover_types = ('titles_only_12', 'image_only', 'lower_titles_6',
                    'upper_titles', 'mixed_titles', 'sidebar_titles');

my $cover_type = "titles_only_12";

my @cover_colours = ([0, 159, 34],
                     [180, 20, 40],
                     [18, 220, 40],
                     [45, 220, 95],
                     [10, 20, 210]);

my $cover_colour = "";

GetOptions(
    'type=s' => \$cover_type,
    'colour=s' => \$cover_colour
) or die "Unknown command line option";

# Select at random public domain image

# Colourise at random for the pastel

# Add fixed text (Title, date, cover price)

# Add deformed names + titles

#GD::Simple->class('GD::SVG');

my $surface = Cairo::ImageSurface->create('argb32', $width, $height);
my $cr = Cairo::Context->create($surface);
#$img->bgcolor('white');
#my $white= $img->colorAllocate(255, 255, 255);
#my $black = $img->colorAllocate(0, 0, 0);
#my $blue= $img->colorAllocate(30, 40, 250);

#$cr->rectangle(10, 10, 40, 40);
$cr->set_source_rgb(100, 20, 100);
$cr->fill;


#exit(0);

#$img->string(gdGiantFont, 100, 20, "John Lanchester: 'Game of Thrones'", $blue);
#$img->string(gdGiantFont, 150, 50, "London Review", $black);
#$img->string(gdGiantFont, 250, 80, "of Allsorts", $black);
#$img->string(gdLargeFont, 100, 100, "Volume 42 Number 26 1 Jan 2014 £3.50 US & Canada \$4.95", $black);

# Put in some titles

open(my $fh, "../sample/silly-titles.txt") or die "Failed to open titles";
while(<$fh>) {
    chomp;
    push @titles, $_;
}
close($fh);

open(my $fh, "../sample/silly-authors.txt") or die "Failed to open authors";
while(<$fh>) {
    chomp;
    push @authors, $_;
}
close($fh);

$cr->rectangle(0, 0, 1280, 1920);
$cr->set_source_rgb(255, 255, 255);
$cr->fill();

$cr->rectangle(25, 75, 1230, 1820);
$cr->set_source_rgb(0, 0, 0);
$cr->fill();

$cr->rectangle(26, 76, 1228, 1818);
my @cover_colour = @{$cover_colours[rand (@cover_colours)]};
$cr->set_source_rgb(@cover_colour);
$cr->fill();

$cr->stroke();
$cr->select_font_face('sans', 'normal', 'bold');
$cr->set_font_size(120);
$cr->set_source_rgb(0, 0, 0);

$cr->move_to(125, 200);
$cr->show_text("London Review");

$cr->set_font_size(80);
$cr->move_to(375, 300);
$cr->show_text("of Sweets");

$cr->set_font_size(38);

my($orig_title,$item,$title) = split(/,/, splice(@titles, rand @titles, 1));
if(exists $used_titles{$orig_title}) { next; }
if(exists $used_items{$item}) { next; }
$used_titles{$orig_title} = 1;
$used_items{$item} = 1;

my $top_title = $title;
my $top_author = splice(@authors, rand @authors, 1);
my $top_line = "$top_author: $top_title";
my $extents = $cr->text_extents($top_line);
say "Text Extents: ", $extents->{height}, " ", $extents->{width};

$cr->move_to($width/2 - ($extents->{width}/2), 50);
$cr->set_source_rgb(200, 0, 0);
$cr->show_text("$top_author: $top_title");

$cr->move_to(250, 350);
$cr->set_source_rgb(0, 0, 0);
$cr->set_font_size(20);
$cr->show_text("Volume 36 Number 1   1 Jan 2015   £3.50 US & CANADA \$4.95");

if($cover_type eq "titles_only_12") {
    my $i = 0;
    $cr->set_font_size(38);
    while($i < 12) {
        my($orig_title,$item,$title) = split(/,/, splice(@titles, rand @titles, 1));
        if(exists $used_titles{$orig_title}) { next; }
        if(exists $used_items{$item}) { next; }
        $used_titles{$orig_title} = 1;
        $used_items{$item} = 1;
        chomp $title;
        my $author = splice(@authors, rand @authors, 1);
        my $line = "$author: $title";
        my $extent = $cr->text_extents($line);
        if($extent->{width} > 1200) { 
            while($extent->{width} > 1200) {
                my($orig_title,$item,$title) = split(/,/, splice(@titles, rand @titles, 1));
                if(exists $used_titles{$orig_title}) { next; }
                if(exists $used_items{$item}) { next; }
                $used_titles{$orig_title} = 1;
                $used_items{$item} = 1;
                chomp $title;
                $line = "$author: $title";
                $extent = $cr->text_extents($line);
            }
        }
        $cr->move_to($width/2 - $extent->{width}/2, 600 + $i*100);
        if(int($i / 2) == 0) {
          $cr->set_source_rgb(200, 0, 0);
        } else {
          $cr->set_source_rgb(0, 0, 0);
        }
        $cr->show_text("$author: $title");
        $cr->fill();
        $i++;
    }
} else {
    $cr->set_font_size(40);

    say "Image Only";

    my $i = 0;
    while($i < 4) {
        my($orig_title,$item,$title) = split(/,/, splice(@titles, rand @titles, 1));
        if(exists $used_titles{$orig_title}) { next; }
        if(exists $used_items{$item}) { next; }
        $used_titles{$orig_title} = 1;
        $used_items{$item} = 1;
        chomp $title;
        my $author = splice(@authors, rand @authors, 1);
        my $line = "$author: $title";
        my $extent = $cr->text_extents($line);
        if($extent->{width} > 1400) { $i++; next; }
        $cr->move_to($width/2 - $extent->{width}/2, 600 + $i*60);
        if(int($i / 2) == 0) {
            $cr->set_source_rgb(200, 0, 0);
        } else {
            $cr->set_source_rgb(0, 0, 0);
        }
        $cr->show_text("$author: $title");
        $cr->fill();
        $i++;
    }

    my $cover_img = $surface->create_from_png("test.png");
    $cr->set_source_surface($cover_img, 100, 850);
    $cr->paint();
}

$cr->show_page;
$surface->write_to_png('output.png');

exit(0);

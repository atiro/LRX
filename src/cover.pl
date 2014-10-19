#!/usr/bin/perl

use strict;
use Cairo;

my @titles;
my @authors;

# Select at random public domain image

# Colourise at random for the pastel

# Add fixed text (Title, date, cover price)

# Add deformed names + titles

#GD::Simple->class('GD::SVG');

my $surface = Cairo::ImageSurface->create('argb32', 1280, 1920);
my $cr = Cairo::Context->create($surface);
#$img->bgcolor('white');
#my $white= $img->colorAllocate(255, 255, 255);
#my $black = $img->colorAllocate(0, 0, 0);
#my $blue= $img->colorAllocate(30, 40, 250);

#$cr->rectangle(10, 10, 40, 40);
$cr->set_source_rgb(0, 0, 0);
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

$cr->set_source_rgb(0, 0, 0);
$cr->rectangle(25, 75, 1230, 1820);

$cr->stroke();
$cr->select_font_face('sans', 'normal', 'bold');
$cr->set_font_size(120);
$cr->set_source_rgb(0, 0, 0);

$cr->move_to(125, 200);
$cr->show_text("London Review");

$cr->set_font_size(80);
$cr->move_to(375, 300);
$cr->show_text("of Allsorts");

$cr->set_font_size(35);

my $top_title = splice(@titles, rand @titles, 1);
my $top_author = splice(@authors, rand @authors, 1);

$cr->move_to(150, 50);
$cr->set_source_rgb(200, 0, 0);
$cr->show_text("$top_author: $top_title");

$cr->move_to(250, 350);
$cr->set_source_rgb(0, 0, 0);
$cr->set_font_size(24);
$cr->show_text("Volume 36 Number 1   1 Jan 2015   £3.50 US & CANADA \$4.95");

$cr->set_font_size(35);

my $i = 0;
while($i < 4) {
    my $title = splice(@titles, rand @titles, 1);
    my $author = splice(@authors, rand @authors, 1);
    $cr->move_to(175, 600 + $i*60);
    if($i / 2 == 0) {
       $cr->set_source_rgb(200, 0, 0);
    } else {
       $cr->set_source_rgb(0, 0, 0);
    }
    $cr->show_text("$author: $title");
    $cr->fill();
    $i++;
}

my $cover_img = $surface->create_from_png("test.png");
$cr->set_source_surface($cover_img, 150, 850);
$cr->paint();

$cr->show_page;
$surface->write_to_png('output.png');

exit(0);

open my $out, '>', '../covers/img.png' or die;
binmode $out;
#print $out $img->png;
close $out;

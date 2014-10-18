#!/usr/bin/perl

use strict;
use GD;
use GD::Simple;

my @titles;

# Select at random public domain image

# Colourise at random for the pastel

# Add fixed text (Title, date, cover price)

# Add deformed names + titles

#GD::Simple->class('GD::SVG');

my $img = GD::Simple->new(640, 1024);
$img->bgcolor('white');

my $white= $img->colorAllocate(255, 255, 255);
my $black = $img->colorAllocate(0, 0, 0);
my $blue= $img->colorAllocate(30, 40, 250);

$img->string(gdGiantFont, 100, 20, "John Lanchester: 'Game of Thrones'", $blue);

$img->string(gdGiantFont, 150, 50, "London Review", $black);
$img->string(gdGiantFont, 250, 80, "of Sweets", $black);
$img->string(gdLargeFont, 100, 100, "Volume 42 Number 26 1 Jan 2014 £3.50 US & Canada \$4.95", $black);

# Put in some titles

open(my $fh, "../sample/silly-titles.txt") or die "Failed to open titles";

while(<$fh>) {
    chomp;
    push @titles, $_;
}

my $i = 0;
while($i < 5) {
    my $title = $titles[rand @titles];
    $img->string(gdGiantFont, 200, 200 + $i*50, $title, $black);
    $i++;
}

open my $out, '>', 'img.png' or die;
binmode $out;
print $out $img->png;


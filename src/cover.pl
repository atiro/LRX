#!/usr/bin/perl

use strict;
use GD;
use GD::Simple;

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

$img->string(gdLargeFont, 100, 20, "John Lanchester: 'Game of Thrones'", $blue);

open my $out, '>', 'img.png' or die;
binmode $out;
print $out $img->png;


#!/usr/bin/perl

# course: cmps3500
# lab 5
# date: 03/13/20
# username: bgarza
# name: Benjamin Garza
# description: 

# Usage: lab05.perl [-h] -f <infile> -o <outfile>

# lab05.perl
use strict;
use warnings;
use Scalar::Util 'looks_like_number';

# demonstrate file i/o and parsing cmdline args

my $inf;                                   # input file handle
my $outf;                                   # input file handle
my $infile = '';
my $outfile = '';
my $index = 0;

##########################
# PARSE CMDLINE ARGS
##########################
while (@ARGV) {                         # parse command line arguments 
  if ($ARGV[0] eq '-f') {
    shift;                              # move array elements up 
    $infile = $ARGV[0];
    shift;
    next;                               # jump to start of while loop 
  }
  if ($ARGV[0] eq '-o') {
    shift;                              # move array elements up 
    $outfile = $ARGV[0];
    shift;
    next;                               # jump to start of while loop 
  }
  elsif ( $ARGV[0] eq '-h') {           # display usage 
     print "\nUsage: lab05.perl [-h] -f <infile> -o <outfile>\n\n";
     shift;
     if (!@ARGV) {
        exit;
     }
     else {
       next; }
  } 
  else {   
     shift;                             # unknown argument so skip it
     next;
  }
}

if (!($infile && $outfile))
{
   print "\nUsage: lab05.perl [-h] -f <infile> -o <outfile>\n\n";
   exit;
}

# now open the files 
open($inf, '<', $infile) or die "Can't read input file: $!";    

my @line;
my $line;
my @field;
my $field;
my %students;
my @count = (0,0,0,0,0,0,0,0,0,0);
my $size = 0;

while(<$inf>) 
{
   chomp;                        # remove CR LF from $_
   push @line, $_;
   $size += 1;
}     
close($inf);
open($outf, '>', $outfile);    

print "Lines read: ", $size , "\n";

foreach(@line) 
{
   $line = $_;
   $line =~ tr/A-Z/a-z/;      # make lowercase
   @field = split ',', $line;    # split by comma
   foreach(@field) 
   {
      $field = $_;
      if ($index > 2 && $field eq "1") 	#if field is a question and is correct then modify count
      {
         @count[$index - 2] += 1;
      }
      $index += 1;
   }
   $students{@field[0]} = @field[1]; 	#add ID and name to hash table
}

print "Enter an ID to query: ";
my $a_word = <stdin>;                   # read from stdin
chomp $a_word;
if ($students{$a_word})
{
   print $a_word, " is ", $students{$a_word}, "\n";
}
else
{
   print $a_word, " is not found\n";
}

my @sorted = sort @line;
my $sorted;

# get sevens and print datas to outfile
print $outf "Lines Sorted by ID and Filtered by ID with 2nd Digit >= 7\n";
foreach(@sorted) 
{
   $sorted = $_;
   if ($sorted =~ /^.7*/)
   {
      print $outf $sorted, "\n";
   }  
}

# print correct counts
print $outf "Correct counts:\n";
$index = 0;
my $maxIndex = 0;
foreach(@count) 
{
   print $outf "#", $index + 1, ": ", @count[$index]  , " "; 
   if (@count[$index] >= @count[$maxIndex])
   {
      $maxIndex = $index;
   }
   $index = $index + 1;
}

# print most most correct
print $outf "Question most frequently answered correctly: #", $maxIndex + 1, "\n";


close($outf);


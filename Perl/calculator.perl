#!/usr/bin/perl

# course: cmps3500
# CLASS Project
# PERL IMPLEMENTATION OF A CUSTOM SCIENTIFIC CALCULATION
# date: 05/05/2020
# Student 1: Benjamin Garza
# Student 2: Rodrigo Ortiz-Carrion
# description: Implementation of a scientific calculator ...

# Usage: calculator.perl [-h] <x: number> <op: operation> [y: number]

# calculator.perl

use strict;
use warnings;
use Scalar::Util 'looks_like_number';

my $x = 0;
my $op = '+';
my $y = 0;
my $result = 0;

if(!@ARGV) {
   print "\nError See Usage\nUsage: calculator.perl [-h] <x: number> <op: operation> [y: number]\n\n";
}

##########################
# PARSE CMDLINE ARGS
##########################
while (@ARGV) {                         # parse command line arguments 
  if (looks_like_number($ARGV[0])) {
    shift;                              # move array elements up 
    $op = $ARGV[0];
    #if ($op eq '+')
    shift;
    next;                               # jump to start of while loop 
  }
  elsif ( $ARGV[0] eq '-h') {           # display usage 
     print "\nUsage: calculator.perl [-h] <x: number> <op: operation> [y: number]\n";
     print "Supported Operators: \n";
     print "   +   : Addition\n";
     print "   -   : Subtraction\n";
     print "   *   : Multiplication\n";
     print "   /   : Division\n";
     print "   sin : Sine of x in degrees\n";
     print "   cos : Cosine of x in degrees\n";
     print "   tan : Tangent of x in degrees\n";
     print "   exp : Exponential of x\n";
     print "   ln  : Natural Log of x\n";
     print "   sqrt: Square Root of x\n";
     print "   sqr : Square of x\n";
     print "   cbrt: Cubed Root of x\n";
     print "   cube: Cube of x\n\n";
     shift;
     if (!@ARGV) {
        exit;
     }
     else {
       next; }
  } 
  else {                                # error in parsing
     print "\nParsing Error See Usage\nUsage: calculator.perl [-h] <x: number> <op: operation> [y: number]\n";
     exit;
  }
}
#!/usr/bin/perl

# course: cmps3500
# CLASS Project
# PERL IMPLEMENTATION OF A CUSTOM SCIENTIFIC CALCULATION
# date: 05/05/2020
# Student 1: Benjamin Garza
# Student 2: Rodrigo Ortiz-Carrion
# description: Implementation of a scientific calculator ...
# Usage: calculator.perl [-h] <x: number> <op: operation> [y: number]

use strict;
use warnings;
use Scalar::Util 'looks_like_number';

# Define variables 
my $x = 0;
my $op = '+';
my $y = 0;
my $result = 0;

# Define Subroutines
#binary takes three arguments and returns the result of the binary operation
sub binary {
   if ($_[1] eq '+') {
      return $_[0] + $_[2];
   } else if ($_[1] eq '-') {
      return $_[0] - $_[2];
   } else if ($_[1] eq '*') {
      return $_[0] * $_[2];
   } else if ($_[1] eq '/') {
      return $_[0] / $_[2];
   } else {
      print "Error in binary\n\n";
      exit;
   }
}

#unary takes two arguments and returns the result of the unary operation
sub unary {
   if ($_[1] eq 'sin') {
      return sin($_[0]);
   } else if ($_[1] eq 'cos') {
      return cos($_[0]);
   } else if ($_[1] eq 'tan') {
      return tan($_[0]);
   } else if ($_[1] eq 'exp') {
      return exp($_[0]);
   } else if ($_[1] eq 'ln') {
      return ln($_[0]);
   } else if ($_[1] eq 'sqrt') {
      return sqrt($_[0]);
   } else if ($_[1] eq 'sqr') {
      return $_[0] * $_[0];
   } else if  ($_[1] eq 'cbrt') {
      return $_[0] ** (1/3);
   } else if ($_[1] eq 'cube') {
      return $_[0] ** 3;
   } else {
      print "Error in unary\n\n";
      exit;
   }
}


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

    if ($op eq '+' | $op eq '-' | $op eq '*' | $op eq '/') {
       shift;
       if(looks_like_number($ARGV[0])) {
          $y = $ARGV[0];
       } else {
          # Print Error or Do nothing
       }

    } else if ($op eq 'sin' | $op eq 'cos' | $op eq 'tan' | $op eq 'exp' | $op eq 'ln' | $op eq 'sin' | $op eq 'sin' | $op eq 'sin' | $op eq 'sin') {

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
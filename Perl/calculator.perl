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
use Math::Trig;
use Scalar::Util 'looks_like_number';

# Define variables 
my $x = 0;
my $op = ' ';
my $y = 0;
my $result = 0;

# Define Subroutines
#binary takes three arguments and returns the result of the binary operation
sub binary {
	if ($_[1] eq '+') {
		return $_[0] + $_[2];
	} elsif ($_[1] eq '-') {
		return $_[0] - $_[2];
	} elsif ($_[1] eq '*') {
		return $_[0] * $_[2];
	} elsif ($_[1] eq '/') {
		unless ($_[2]) { return 'undefined: division by 0'}
		return $_[0] / $_[2];
	} elsif ($_[1] eq 'x^y') {
		return $_[0] ** $_[2];
	} elsif ($_[1] eq '%') {
		unless ($_[2]) { return 'undefined: modulo by 0'}
		return $_[0] % $_[2];
	} else {
		print "Error in binary\n\n";
	}
}

#unary takes two arguments and returns the result of the unary operation
sub unary {
	if ($_[1] eq 'sin') {
		return sin($_[0] * pi() / 180);
	} elsif ($_[1] eq 'cos') {
		return cos($_[0] * pi() / 180);
	} elsif ($_[1] eq 'tan') {
		return tan($_[0] * pi() / 180);
	} elsif ($_[1] eq 'e^x') {
		return exp($_[0]);
	} elsif ($_[1] eq 'ln') {
		unless ($_[0]) { return 'undefinded'; } 
		return log($_[0]);
	} elsif ($_[1] eq 'sqrt') {
		unless($_[0] >= 0) { return sqrt($_[0] * -1) . 'i'; }
		return sqrt($_[0]);
	} elsif ($_[1] eq '2^x') {
		return 2.0 ** $_[0];
	} elsif  ($_[1] eq 'cbrt') {
		unless($_[0] >= 0) { return (-1*(($_[0] * -1)**(1/3))); }
		return $_[0] ** (1/3);
	} elsif ($_[1] eq '3^x') {
		return 3 ** $_[0];
	} else {
		print "Error in unary\n\n";
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
      $x = $ARGV[0];
		shift;                              # move array elements up 
		$op = $ARGV[0];

		if ($op eq '+' | $op eq '-' | $op eq '*' | $op eq '/' | $op eq '%' | $op eq 'x^y') {
			shift;
			if(looks_like_number($ARGV[0])) {
				$y = $ARGV[0];
            $result = binary($x, $op, $y);
            print "Binary result: ", $result, " \n";
            last;
			} else {
            # Print Error or Do nothing
			}
		} elsif ($op eq 'sin' | $op eq 'cos' | $op eq 'tan' | $op eq 'e^x' | $op eq 'ln' | $op eq 'sqrt' | $op eq 'sqr' | $op eq 'cbrt' | $op eq '2^x' | $op eq '3^x') {
         $result = unary($x, $op);
         print "Unary result: ", $result, " \n";
         last; 
		} else {
			print "Error 89\n\n";
			exit;
		}
      last;
   } elsif ( $ARGV[0] eq '-h') {           # display usage 
      print "\nUsage: calculator.perl [-h] <x: number> <op: operation> [y: number]\n";
      print "Supported Operators: \n";
      print "   +   : Addition\n";
      print "   -   : Subtraction\n";
      print "   \*  : Multiplication\n";
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
   } else {                                # error in parsing
      print "\nParsing Error See Usage\nUsage: calculator.perl [-h] <x: number> <op: operation> [y: number]\n";
      exit;
   }
}

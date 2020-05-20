#!/usr/bin/perl

# course: cmps3500
# CLASS Project
# PERL IMPLEMENTATION OF A CUSTOM SCIENTIFIC CALCULATION
# date: 05/05/2020
# Student 1: Benjamin Garza
# Student 2: Rodrigo Ortiz-Carrion
# description: Implementation of a scientific calculator ...

use strict;
use warnings;
use diagnostics;
use Math::Trig;
use Scalar::Util 'looks_like_number';
use Tk 800;
use Tk::Entry;
use Tk::Button;
use Tk::DialogBox;

my $calc    = '0.00';
my $r       = 0;
my $w       = '0';
my %button;
my @rows;


# State:
# 	0: No input
#	1: x input done
#	2: op input done
#	3: y input done
my $state = 0;
my $x = 0;
my $y;
my $op = '';
my $dbuffer = '';


# Create calculator window with title
my $window = new MainWindow(-title => 'Calculator', -background => 'black');
$window->geometry("400x300");

my $topframe = $window->Frame(-height => '100', -width => '300', -background => 'black')->pack(-side => 'top', -expand => '0', -fill => 'x');
my $btmframe = $window->Frame(-height => '225', -width => '300',-background => 'black')->pack(-side => 'left', -expand => '1', -fill => 'both');
push @rows, $btmframe->Frame()->pack( -expand => 1, -fill => 'both', -side => 'top') for (0..4);

my $display   =  $topframe->Entry(-justify      => 'right',
		-state        => 'disabled', 
		-background => 'white',
		-foreground => 'black',
		-textvariable => \$calc)
->pack(-expand       => '1',
		-fill         => 'x',
		-pady         => 1,
		-padx         => 1,
		-side         => 'right');

$window->bind("<KeyRelease>" , sub { &keypress } );

# Create a button for every parsed string below
for my $i (
	qw/
	sin ln AC C +\/- % 
	cos e^x 7 8 9 \/
	tan 2^x 4 5 6 *
	sqrt 3^x 1 2 3 - 
	cbrt x^y 0 . = +
	/ )
{
	$button{$i} = $rows[$r]->Button(-text    => "$i", 
		-width   => '3', 
		-height  => '1', 
		-command => sub { &btnpress($i) },
		-background => 'blue',
		-foreground => 'white')
	->pack(-expand  => 1,
		-fill    => 'both',
		-padx    => 2, 
		-pady    => 2,
		-side    => 'left',
		-ipadx   => 5, 
		-ipady   => 5);

	$w++;

	if ($w > 5) { $w = 0; $r++; }
}

MainLoop;

#Every time a button is pressed, it calls this sub routine
sub btnpress {
	my $btn = shift;

	# Calculator can return strings, so make sure your not using one
	if (!looks_like_number($x)) {$x = $dbuffer;}

	# Clear
	if ($btn eq 'C') 
	{	
		$dbuffer = '';
		if ($state lt 2) { $x = 0; $state = 0;} # Remember to set state back one
		else {$y = 0; $state = 2;}
		concatenation('0');
	}

	# Complete reset
	elsif ($btn eq 'AC')
	{
		$dbuffer = '';
		$calc   = '0.00';
		$x = 0;
		$y = 0;
		$op = '';
		$state = 0;
	}

	elsif ($state lt '2')
	{
		if ($btn eq '+/-')
		{ 
			$x = $x * -1; 
			$dbuffer = $x; 
			$calc = sprintf "%0.2f", $dbuffer; 
		}

		# Unary operations calls unary function and returns calue to x
		elsif ($btn eq 'sin' | $btn eq 'cos' | $btn eq 'tan' | $btn eq 'e^x' | $btn eq 'ln' | $btn eq 'sqrt' | $btn eq '2^x' | $btn eq 'cbrt' | $btn eq '3^x')
		{
			$op = $btn;
			$x = unary($x, $op);
			$dbuffer = '';
			$calc = sprintf "%s", $x;
			$state = 1;
		}

		# Binary functions also return to x but are not called till y has been input, save operation under op
		elsif ($btn eq '+' | $btn eq '-' | $btn eq '*' | $btn eq '/' | $btn eq '%' | $btn eq 'x^y')
		{ 
			$op = $btn; 
			$state++; 	
			$dbuffer = ''; 
			$calc = sprintf "%0.2f %s ", $x, $op;
		}

		else {concatenation($btn); $state = 1;}
	}

	elsif ($state gt '1')
	{
		if ($btn eq '+/-')
		{ 
			$y = $y * -1; 
			$dbuffer = $y; 
			$calc = sprintf "%0.2f %s %0.2f", $x, $op, $dbuffer; 
		}
		elsif ($btn eq '=')
		{
			$x = binary($x, $op, $y);
			$state = 1;
			$y = 0;
			$dbuffer = '';
			$calc = sprintf "%s", $x; 
		}
		else {concatenation($btn); $state = 3;}
	}
}

sub concatenation {

	my $btn = shift;

	if( $btn =~ /(\d)|\./)
	{ 
		# Different states have different outputs/changes
		if ($state lt '2') { $dbuffer = $dbuffer . $btn; $x = $dbuffer; } 
		else {$dbuffer = $dbuffer . $btn; $y = $dbuffer; }
	}
	unless( $btn =~ /(\d)|\./){  }

 	if( $btn =~ /(\d)|\./)
	{
		if ($state lt '2') {$calc = sprintf "%0.2f", $x;}
		else {$calc = sprintf "%0.2f %s %0.2f", $x, $op, $dbuffer; }
	}
}


sub keypress{

	if($_[0] ne 'q'){
		my $widget = shift;
		my $e = $widget->XEvent;    # get event object
			my $btn = $e->K;
		$btn=~s/period/\./ig;

		if( $btn =~/c/ig ){ $btn = uc $btn; $button{$btn}->invoke; }
		if( $btn =~/q/ig ){ exit 0; }    
		if( $btn =~/(\d)|\./){ &btnpress($btn); }
	}
	else
	{
		exit 0;
	}
}


# Evaluates binary functions with error checking
# Params: $x $op $y
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

# Evaluates unary functions with error checking
# Params: $x $op 
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
		unless ($_[0] > 0) { return 'undefined ln(x) x <= 0'; } 
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
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
use diagnostics;
use Scalar::Util 'looks_like_number';

use Tk 800;
use Tk::Entry;
use Tk::Button;
use Tk::DialogBox;

my $calc    = '0.00';
my $r       = 0;
my $w       = '0';
my $h       = 1;
my $dbuffer  = '';
my %button;
my @rows;

my $x = 0;
my $op = 0;
my $y = 0;
my $ret = 0;
my $state = 0; 

# 4 states:
#	1) No values have been set
#	2) x has been set
#	3) op has been set
#	4) y has been set

my $mw = new MainWindow(-title => 'Calculator');
$mw->geometry("600x300");

my $topframe = $mw->Frame(-height => '60', -width => '300')->pack(-side => 'top', -expand => '0', -fill => 'x');
my $btmframe = $mw->Frame(-height => '225', -width => '300',)->pack(-side => 'left', -expand => '1', -fill => 'both');
push @rows, $btmframe->Frame()->pack( -expand => 1, -fill => 'both', -side => 'top') for (0..4);

my $display   =  $topframe->Entry(-justify      => 'right',
	-state        => 'disabled', 
	-textvariable => \$calc)
->pack(-expand       => '1',
	-fill         => 'x',
	-pady         => 20,
	-padx         => 20,
	-side         => 'right');

$mw->bind("<KeyRelease>" , sub { &keypress } );


for my $i (
	qw/
	sin(x) ln(x) AC C +\/- % 
	cos(x) e^x 7 8 9 \/
	tan(x) 2^x 4 5 6 *
	sqrt(x) 3^x 1 2 3 - 
	cbrt(x) x^y 0 . = +
	/
)
{
	$button{$i} = $rows[$r]->Button(-text    => "$i", 
		-width   => '3', 
		-height  => "$h", 
		-command => sub { &btnpress($i) })
	->pack(-expand  => 1,
		-fill    => 'both',
		-padx    => 2, 
		-pady    => 2,
		-side    => 'left',
		-ipadx   => 5, 
		-ipady   => 5);

	$w++;
	$h = 1;

	if($w > 5){$w = 0; $r++;}
}

MainLoop;

sub btnpress{
	my $btn = shift;

	if($state lt '2' && looks_like_number($btn))
	{
		$buffer = $x * 10 + $btn;
		$calc = sprintf "%0.2f", $buffer;
		$state = 1;
		$x = $buffer;
	} 
	elsif ($state eq '1' && !looks_like_number($btn) && $btn ne '=' && $btn ne '*C')
	{
		# Correct the division operator error
		if ($btn eq '\/')
		{
			$btn = '\\\/';
		}

		# Check Unary or Binary
		# For unary don't wait for equal button, just compute
		# Return as x and manually set state
		if (unary($btn))
		{
			$x = calculator($x, $op);
			$dbuffer = $x;
			$calc = sprintf "%0.2f", $dbuffer;
			$state = 1;
		}
		else 
		{
			$dbuffer = $dbuffer . $btn;
			$calc = sprintf "%0.2s", $dbuffer;
			$state++;
			$op = $btn;
		}

	}
	elsif ($state eq '2' && looks_like_number($btn))
	{
		$buffer = $buffer . $btn;
		$calc = sprintf "%0.2s", $buffer;
		$state++;
		$y = $btn;
	} 
	elsif ($state eq '3' && $btn eq '=')
	{
		$x = calculator($x, $op, $y);
	}
}


sub unary {
	if (
		$_[0] eq 'sin(x)' ||
		$_[0] eq 'cos(x)' ||
		$_[0] eq 'tan(x)' ||
		$_[0] eq 'ln(x)' ||
		$_[0] eq 'e^x' ||
		$_[0] eq '2^x' ||
		$_[0] eq '3^x' ||
		$_[0] eq 'sqrt(x)' ||
		$_[0] eq 'cbrt(x)' ||
		$_[0] eq 'sin(x)' ||
		$_[0] eq 'sin(x)' 
		)
	{
		return 1;
	}
	else { return 0; }
}

sub keypress{

	if($_[0] ne 'q'){
		my $widget = shift;
		my $e = $widget->XEvent;    # get event object
		my $btn = $e->K;
		$btn=~s/period/\./ig;

		if( $btn =~/c/ig ){ $btn = c $btn; $button{$btn}->invoke; }
		if( $btn =~/q/ig ){ exit 0; }    
		if( $btn =~/(\d)|\./){ &btnpress($btn); }
	}
	else
	{
		exit 0;
	}
}
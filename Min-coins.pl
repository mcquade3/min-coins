#!/usr/local/bin/perl
# Mike McQuade
# Min-coins.pl
# Counts the minimum number of coins needed to add up
# to a certain number.

use strict;
use warnings;
use integer;
use List::Util qw(min);

# Initialize variables
my ($sum,@coins);

# Open the file to read
open(my $fh,"<ba5a.txt") or die $!;

# Read in the values from the file
$sum = <$fh>;
chomp($sum);
@coins = split(/\D/,<$fh>);

my @numCoins = (0); # If the sum is zero, zero coins are required

# If the sum is greater than zero, the number of coins
# is calculated iteratively by calculating the number of coins
# for each sum up to and including the given number.
for (my $i = 1; $i <= $sum; $i++) {
	foreach my $coin (@coins) {
		# The algorithm only checks the calculations for a coin
		# if the coin is less than the sum.
		if ($i >= $coin) {
			# The value for each spot in the array is initialized
			# with the value of the past calculated sum plus 1.
			if (!defined $numCoins[$i]) {$numCoins[$i] = $numCoins[$i - $coin] + 1}
			# After the values have been defined, the algorithm compares the
			# initial value to the value of one of the past sums, depending
			# on the amount the coin is worth.
			else {$numCoins[$i] = min($numCoins[$i],$numCoins[$i - $coin] + 1)}
		}
	}
}
print $numCoins[$sum]."\n";

# Close the file
close($fh) || die "Couldn't close file properly";
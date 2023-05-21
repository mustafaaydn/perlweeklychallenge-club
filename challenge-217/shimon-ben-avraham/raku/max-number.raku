#! /usr/bin/env raku

# Perl Weekly Challenge 217-2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Sat 20 May 2023 11:16:24 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Max Number

=SUBTITLE
=head2 Submitted by: Mohammad S Anwar

=CHALLENGE
=head2
You are given a list of positive integers.
Write a script to concatenate the integers to form the highest possible value.

=head3 Example 1:

    Input: @list = (1, 23)

    Output: 231

=head3 Example 2:

    Input: @list = (10, 3, 2)

    Output: 3210

=head3 Example 3:

    Input: @list = (31, 2, 4, 10)

    Output: 431210

=head3 Example 4:

    Input: @list =   (5, 15, 4, 123, 2)

    Output: 542111

=head3 Example 5:

    Input: @list = (1, 10)

    Output: 110

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

# We need a special comparison function.
# It will compare each digit in the two numbers.
# If one number has more digits than the other,
# the longer one always compares its remaining digits 
# to the last digit of the shorter one.
sub max-number-cmp (UInt:D $a, UInt:D $b --> Order:D) {
    my @a=$a.comb; 
    my @b=$b.comb; 
    my $l = max(+@a, +@b); 
    for ^$l -> $i {  
        my $a = @a[$i] // @a[$i-1];
        my $b = @b[$i] // @b[$i-1];
        return $b <=> $a unless $a == $b;
    } 
    return Same;
} # end of my sub a (UInt:D $a, UInt:D $b --> Order:D)

# Here's the solution to the challenge. It uses the comparison function above.
sub max-number (@list where .all ~~ UInt --> UInt) {
   return @list.sort(&max-number-cmp).join.UInt;
} # end of sub max-number (@list where .all ~~ UInt --> UInt)

# run `raku max-number.raku --test` to verify that all the examples work.
multi MAIN (:$test!) {
    use Test;

    my @tests = [
        %{ input => (1, 23),          output => 231,    text => 'Example 1' },
        %{ input => (10, 3, 2),       output => 3210,   text => 'Example 2' },
        %{ input => (31, 2, 4, 10),   output => 431210, text => 'Example 3' },
        %{ input => (5, 11, 4, 1, 2), output => 542111, text => 'Example 4' },
        %{ input => (1, 10),          output => 110,    text => 'Example 5' },
    ];

    for @tests {
        is max-number( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )



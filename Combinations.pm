package Math::Combinations;

use strict;
use warnings;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(combinations_without_repetition
                 combinations_with_repetition
                 num_rem);

our $VERSION = '1.00';

sub combinations_without_repetition {
    my ($ref_words, $k) = @_;
    my $n = requirements(@_);
    $n || return;
    my $count = 0;
    my $ret_all = ();
    my ($i, @out_num);
    for $i (0..$k-1) {
        $out_num[$i] = $i;
    }
    ++$count;
    my $ret_ref = \&add_arr_comb;
    $ret_all .= ${&$ret_ref(\@out_num, $count, $ref_words)};
    while() {
        $i = $k - 1;
        while($i >= 0 && $out_num[$i] == $n - $k + $i) {
            --$i;
        }
        return $ret_all if $i < 0;
        ++$out_num[$i];
        for($i++; $i < $k; $i++) {
            $out_num[$i] = $out_num[$i - 1] + 1;
        }
        ++$count;
        $ret_all .= ${&$ret_ref(\@out_num, $count, $ref_words)};
    }
}

sub combinations_with_repetition {
    my ($ref_words, $k) = @_;
    my $n = requirements(@_);
    $n || return;
    my $count = 0;
    my $ret_all = ();
    my ($i, @out_num);
    for $i (0..$k-1) {
        $out_num[$i] = 0;
    }
    ++$count;
    my $ret_ref = \&add_arr_comb;
    $ret_all .= ${&$ret_ref(\@out_num, $count, $ref_words)};
    while() {
        $i = $k - 1;
        while($i >= 0 && $out_num[$i] == $n - 1) {
            --$i;
        }
        return $ret_all if $i < 0;
        ++$out_num[$i];
        for($i++; $i < $k; $i++) {
            $out_num[$i] = $out_num[$i - 1];
        }
        ++$count;
        $ret_all .= ${&$ret_ref(\@out_num, $count, $ref_words)};
    }
}

sub requirements {
    my ($ref_words, $k) = @_;
    if ($k <= 0 or $k > @$ref_words) {
        print "Requirements:\n";
        print "k - integer, k > 0\n";
        print "k < or = size of array\n";
        print "Quit\n";
        return;
    } else {
        scalar @$ref_words;
    }
}

sub add_arr_comb {
    my ($ref_out_num, $count, $ref_words) = @_;
    my $ret = ();
    $ret .= "($count) ";
    for my $i (0..$#$ref_out_num)  {
        $ret .= "$ref_words->[$ref_out_num->[$i]] ";
    }
    \($ret .= "\n");
}

sub num_rem {
    my $out = ();
    foreach (split(/\n/, shift)) {
        s/^\(\d+\) //;
        $out .= $_."\n";
    }
    $out;
}

1;

__END__

=head1 NAME

Math::Combinations

=head1 SYNOPSIS

    use Math::Combinations;

    # @words - array for combinatorics; $k - length for combinatorics
    my @words = qw/a1 b2 c3 d4 e5 f6/;
    my $k = 4;
    print "---Combinations without repetition---\n\n";
    print combinations_without_repetition(\@words, $k), "\n";
    print num_rem(combinations_without_repetition(\@words, $k)), "\n";
    my @words = qw/a1 b2 c3/;
    my $k = 3;
    print "---Combinations with repetition---\n\n";
    print combinations_with_repetition(\@words, $k), "\n";
    print num_rem(combinations_with_repetition(\@words, $k)), "\n";


=head1 DESCRIPTION

Combinations without/with repetition

=head1 EXPORT

combinations_without_repetition,
combinations_with_repetition,
num_rem

=head1 AUTHOR

Petar Kaleychev <petar.kaleychev@gmail.com>

=head1 BUGS

Report them to the author

=head1 REFERENCES

Siegfried Koepf, Fast Combinatorial Algorithms in C,
http://www.aconnect.de/friends/editions/computer/combinatoricode_e.html

=head1 SEE ALSO

L<Math::Counting>,
L<Math::Subsets::List>,
L<Math::Combinatorics>,
L<Algorithm::Combinatorics>

=head1 COPYRIGHT

Copyright (c) 2014 Petar Kaleychev

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

use App::St;

my @val_tests = (
    [[1] => 0],
    [[3] => 0],
    [[0, 3] => 0],
    [[1, 1] => 1],
    [[2, 2] => 1],
    [[3, 3, 3, 3] => 2],
    [[4, 4, 4, 4, 4, 4, 4, 4] => 3],
    [[2, 2, 4, 8] => 1.75],
    [[2, 8, 2, 4] => 1.75],
);

sub make {
    return App::St->new( keep_data => 1 );
}

plan tests => 3 + @val_tests;

my $st;

$st = make();
dies_ok { $st->entropy() };

$st = make();
$st->process(0);
$st->process(0);
dies_ok { $st->entropy() };

$st = make();
$st->process(1);
$st->process(-1);
dies_ok { $st->entropy() };

for my $t (@val_tests) {
    $st = make();

    for my $num (@{ $t->[0] }) {
        $st->process($num);
    }

    is($st->entropy(), $t->[1])
}


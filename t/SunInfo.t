#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'sun_info';
zci is_cached   => 0;

# Presume sun will rise in the morning and set at night year round in PA.
my @now = (qr/^On.*Phoenixville, Pennsylvania.*AM.*PM\.$/, html => qr/Phoenixville.*AM.*PM/);
my @aug = (qr/^On 30 Aug.*AM.*PM\.$/, html => qr/Phoenixville.*AM.*PM/);
my @exact = (
    'On 01 Jan 2015, sunrise in Phoenixville, Pennsylvania is at 7:23 AM; sunset at 4:46 PM.',
    html =>
      qr{^<div class='zci--suninfo'><div class='suninfo--header text--secondary'><span class='ddgsi'>.*<img.*4:46 PM</span></span></div></div>$},
);

ddg_goodie_test(
    [qw( DDG::Goodie::SunInfo )],
    'sunrise'                             => test_zci(@now),
    'what time is sunrise'                => test_zci(@now),
    'sunset'                              => test_zci(@now),
    'what time is sunset'                 => test_zci(@now),
    'sunrise for aug 30'                  => test_zci(@aug),
    'sunrise 30 aug'                      => test_zci(@aug),
    'sunset for aug 30?'                  => test_zci(@aug),
    'sunset aug 30th'                     => test_zci(@aug),
    'sunset on 2015-01-01'                => test_zci(@exact),
    'what time is sunrise on 2015-01-01?' => test_zci(@exact),
    'January 1st, 2015 sunrise'           => test_zci(@exact),
    q{sunrise at 39°57'N 75°10'W}         => test_zci(""),
    'sunset at 53N 10E'                   => test_zci(""),
    'sunset at 53S 15W'                   => test_zci(""),
    'sunset at 53N 10E on 2014-01-01'     => test_zci(""),
    'sunset for philly'                   => undef,
    'sunrise on mars'                     => undef,
    'sunset boulevard'                    => undef,
    'tequila sunrise'                     => undef,
    'sunrise mall'                        => undef,
    'after the sunset'                    => undef,
);

done_testing;

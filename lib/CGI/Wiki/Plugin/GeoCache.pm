package CGI::Wiki::Plugin::GeoCache;

use strict;
use Carp qw(croak);
use vars qw( $VERSION );
$VERSION = '0.1';

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub make_link {
	my ($self, %args) = @_;

	# There are three mandatory arguments.
	foreach my $arg ( qw( latitude longitude link_text) ) {
		croak "No $arg supplied" unless $args{$arg};
		$self->{$arg} = $args{$arg};
	}

	my $latitude  = $args{ latitude };
	my $longitude = $args{ longitude };
	my $link_text = $args{ link_text };

	my $link = "<a href=\"http://www.geocaching.com/seek/nearest_cache.asp?origin_lat="
	. $latitude . "&origin_long=" . $longitude . "\">$link_text</a>";

      	return $link;
}

=head1 NAME

CGI::Wiki::Plugin::GeoCache

=head1 DESCRIPTION

Makes links to L<http://www.geocaching.com/> from any CGI::Wiki node with
latitude and longitude data.

=head1 SYNOPSIS

    use CGI::Wiki;
    use CGI::Wiki::Plugin::GeoCache;

    my $geocache = CGI::Wiki::Plugin::GeoCache->new;

    my $link = $geocache->make_link(
			latitude  => $latitude,
			longitude => $longitude,
			link_text  => "Look for nearby geocaches";
		);

=head1 METHODS

=over 4

=item B<make_link>

    my $link = $geocache->make_link(
			latitude  => $latitude,
			longitude => $longitude,
			link_text  => "Look for nearby geocaches";
		);

$latitude and $longitude should be extracted from the metadata for a node in
the wiki script. If $latitude is "51.00000" and $longitude is "-7.00000", this
method will fill $link with a URL of the form:

<a href="http://www.geocaching.com/seek/nearest_cache.asp?origin_lat=51.00000&origin_long=-7.00000">Look for nearby geocaches</a>

You'll then need to pass $link as a TT variable to your templates.

=back

=head1 AUTHOR

Earle Martin (EMARTIN@cpan.org).

=head1 COPYRIGHT

Copyright (C) 2003 Earle Martin.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 CREDITS

Huge respect to Kate Pugh (KAKE) for the fantastic piece of work that
is CGI::Wiki. Thanks also to Ivor Williams (IVORW) for the help he gave
whilst I was writing this module. 

=cut

1;

use CGI::Wiki::TestConfig::Utilities;
use CGI::Wiki;
use URI::Escape;

use Test::More tests =>
  (1 + 3 * $CGI::Wiki::TestConfig::Utilities::num_stores);

use_ok( "CGI::Wiki::Plugin::GeoCache" );

my %stores = CGI::Wiki::TestConfig::Utilities->stores;

my ($store_name, $store);
while ( ($store_name, $store) = each %stores ) {
  SKIP: {
      skip "$store_name storage backend not configured for testing", 3
          unless $store;

      print "#\n##### TEST CONFIG: Store: $store_name\n#\n";

      my $wiki = CGI::Wiki->new( store => $store );
   
      my $geocache = eval {
          CGI::Wiki::Plugin::GeoCache->new;
      };
      is( $@, "",
         "'new' doesn't croak"
      );
      isa_ok( $geocache, "CGI::Wiki::Plugin::GeoCache" );

      my $latitude  = "51.52493";
      my $longitude = "-0.114436";

      my $geocache_link = $geocache->make_link(
					latitude  => $latitude,
					longitude => $longitude,
					link_text => "Find nearby geocaches" 
					);

      like( $geocache_link, qr|\Q<a href="http://www.geocaching.com/seek/nearest_cache.asp?origin_lat=51.52493&origin_long=-0.114436">Find nearby geocaches</a>\E|,
	    "makes the link OK" );

  }
}

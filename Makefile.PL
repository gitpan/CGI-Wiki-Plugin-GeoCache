use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => "CGI::Wiki::Plugin::GeoCache",
    VERSION_FROM => "lib/CGI/Wiki/Plugin/GeoCache.pm",
	      PREREQ_PM => { CGI::Wiki => 0.27, # for initialisation testutils
			     Test::More => 0,
			     Carp => 0
                           }
);

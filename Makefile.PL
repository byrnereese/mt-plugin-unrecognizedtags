use ExtUtils::MakeMaker;

use YAML::Any qw(LoadFile);
my $file = "plugins/UnrecognizedTags/config.yaml";
my $version = LoadFile($file)->{version} ||
    die "No version found in $file";

WriteMakefile(
    NAME            => 'Unrecognized Tags',
    VERSION         => $version,
    DISTNAME        => 'UnrecognizedTags',
);

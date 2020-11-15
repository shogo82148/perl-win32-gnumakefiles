#!/bin/bash

cat <<'END'
package Devel::PatchPerl::Plugin::MinGWGNUmakefile;

use utf8;
use strict;
use warnings;
use 5.026001;
use version;
use Devel::PatchPerl;
use File::pushd qw[pushd];
use File::Spec;

# copy utility functions from Devel::PatchPerl
*_is = *Devel::PatchPerl::_is;
*_patch = *Devel::PatchPerl::_patch;

my @patch = (
    {
        perl => [
            qr/^5\.22\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_522 ],
        ],
    },
    {
        perl => [
            qr/^5\.2[01]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_520 ],
        ],
    },
    {
        perl => [
            qr/^5\.1[89]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_518 ],
        ],
    },
    {
        perl => [
            qr/^5\.1[67]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_516 ],
        ],
    },
    {
        perl => [
            qr/^5\.1[45]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_514 ],
        ],
    },
    {
        perl => [
            qr/^5\.1[23]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_512 ],
        ],
    },
    {
        perl => [
            qr/^5\.1[01]\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_510 ],
        ],
    },
    {
        perl => [
            qr/^5\.9\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_509 ],
        ],
    },
    {
        perl => [
            qr/^5\.8\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_508 ],
        ],
    },
    {
        perl => [
            qr/^5\.7\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_507 ],
        ],
    },
    {
        perl => [
            qr/^5\.6\./,
        ],
        subs => [
            [ \&_patch_gnumakefile_506 ],
        ],
    },
);

sub patchperl {
    my ($class, %args) = @_;
    my $vers = $args{version};
    my $source = $args{source};

    my $dir = pushd( $source );

    # copy from https://github.com/bingos/devel-patchperl/blob/acdcf1d67ae426367f42ca763b9ba6b92dd90925/lib/Devel/PatchPerl.pm#L301-L307
    for my $p ( grep { _is( $_->{perl}, $vers ) } @patch ) {
       for my $s (@{$p->{subs}}) {
         my($sub, @args) = @$s;
         push @args, $vers unless scalar @args;
         $sub->(@args);
       }
    }
}

# it is same as ge operator of strings but it assumes the strings are versions
sub _ge {
    my ($v1, $v2) = @_;
    return version->parse("v$v1") >= version->parse("v$v2");
}

sub _write_or_die {
    my($file, $data) = @_;
    my $fh = IO::File->new(">$file") or die "$file: $!\n";
    $fh->print($data);
}

sub _write_gnumakefile {
    my ($version, $makefile) = @_;
    my @v = split /[.]/, $version;
    $makefile =~ s/__INST_VER__/$version/g;
    $makefile =~ s/__PERL_MINOR_VERSION__/$v[0]$v[1]/g;
    $makefile =~ s/__PERL_VERSION__/$v[0]$v[1]$v[2]/g;

    _write_or_die(File::Spec->catfile("win32", "GNUmakefile"), $makefile);
}

sub _patch_gnumakefile {
    my ($version, $makefile) = @_;
    my @v = split /[.]/, $version;
    $makefile =~ s/__INST_VER__/$version/g;
    $makefile =~ s/__PERL_MINOR_VERSION__/$v[0]$v[1]/g;
    $makefile =~ s/__PERL_VERSION__/$v[0]$v[1]$v[2]/g;
    _patch($makefile);
}

END

cat <<END
sub _patch_gnumakefile_522 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.22.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_520 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.20.0/GNUmakefile)
MAKEFILE
    if (_ge(\$version, "5.21.1")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.20.0/GNUmakefile v5.21.1/GNUmakefile)
PATCH
    }
}

sub _patch_gnumakefile_518 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.18.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_516 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.16.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_514 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.14.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_512 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.12.0/GNUmakefile)
MAKEFILE
    if (_ge(\$version, "5.13.4")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.12.0/GNUmakefile v5.13.4/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.5")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.4/GNUmakefile v5.13.5/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.6")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.5/GNUmakefile v5.13.6/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.7")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.6/GNUmakefile v5.13.7/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.8")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.7/GNUmakefile v5.13.8/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.9")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.8/GNUmakefile v5.13.9/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.10")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.9/GNUmakefile v5.13.10/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.13.11")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.10/GNUmakefile v5.13.11/GNUmakefile)
PATCH
    }
}

sub _patch_gnumakefile_510 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.10.0/GNUmakefile)
MAKEFILE
    if (_ge(\$version, "5.11.2")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.10.0/GNUmakefile v5.11.2/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.11.3")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.11.2/GNUmakefile v5.11.3/GNUmakefile)
PATCH
    }
}

sub _patch_gnumakefile_509 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.9.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_508 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.8.0/GNUmakefile)
MAKEFILE
    if (_ge(\$version, "5.8.3")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.0/GNUmakefile v5.8.3/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.8.5")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.3/GNUmakefile v5.8.5/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.8.6")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.5/GNUmakefile v5.8.6/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.8.7")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.6/GNUmakefile v5.8.7/GNUmakefile)
PATCH
    }
    if (_ge(\$version, "5.8.9")) {
        _patch_gnumakefile(\$version, <<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.7/GNUmakefile v5.8.9/GNUmakefile)
PATCH
    }
}

sub _patch_gnumakefile_507 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.7.0/GNUmakefile)
MAKEFILE
}

sub _patch_gnumakefile_506 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.6.0/GNUmakefile)
MAKEFILE
}
END

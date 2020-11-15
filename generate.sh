#!/bin/bash

cat <<END
sub _patch_gnumakefile_512 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.12.0/GNUMakefile)
MAKEFILE
    if (_ge(\$version, "5.13.8")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.12.0/GNUMakefile v5.13.8/GNUMakefile)
PATCH
    }
    if (_ge(\$version, "5.13.9")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.8/GNUMakefile v5.13.9/GNUMakefile)
PATCH
    }
    if (_ge(\$version, "5.13.10")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.9/GNUMakefile v5.13.10/GNUMakefile)
PATCH
    }
    if (_ge(\$version, "5.13.11")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.13.10/GNUMakefile v5.13.11/GNUMakefile)
PATCH
    }
}

sub _patch_gnumakefile_508 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.8.0/GNUMakefile)
MAKEFILE
    if (_ge(\$version, "5.8.6")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.0/GNUMakefile v5.8.6/GNUMakefile)
PATCH
    }
    if (_ge(\$version, "5.8.7")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.8.6/GNUMakefile v5.8.7/GNUMakefile)
PATCH
    }
}
END

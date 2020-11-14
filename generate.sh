#!/bin/bash

cat <<END
sub _patch_gnumakefile_512 {
    my \$version = shift;
    _write_gnumakefile(\$version, <<'MAKEFILE');
$(cat v5.12.0/GNUMakefile)
MAKEFILE
    if (_ge(\$version, "5.13.11")) {
        _patch(<<'PATCH');
$(diff -L win32/GNUmakefile -L win32/GNUmakefile -u v5.12.0/GNUMakefile v5.13.11/GNUMakefile)
PATCH
    }
}
END

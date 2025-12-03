#!/usr/bin/env bash
set -euo pipefail

export PACKAGE_ROOT="${PACKAGE_ROOT:?PACKAGE_ROOT not set}"
export VERSION="${VERSION:?VERSION not set}"

export PROJ_NAME="openocd-adi"
export PROJ_MAINTAINER="Ozan Durgut <ozan.durgut@analog.com>"

fpm_wrapper () {
  local fmt="$1"
  local mappings=()

    mappings+=("usr/local/bin/openocd=/usr/bin/openocd-adi")
    mappings+=("usr/share/openocd-adi/openocd=/usr/share/openocd-adi/openocd")
    mappings+=("usr/share/openocd-adi/man/man1/openocd.1=/usr/share/man/man1/openocd-adi.1")
    mappings+=("usr/share/openocd-adi/info/openocd.info=/usr/share/info/openocd-adi.info")
    mappings+=("usr/local/share/doc/openocd=/usr/share/doc/openocd-adi")

  echo ">>> Packaging $fmt"

  fpm \
    -s dir \
    -t "$fmt" \
    -n "$PROJ_NAME" \
    -v "$VERSION" \
    -m "$PROJ_MAINTAINER" \
    --license "GPL-2.0" \
    --url "https://github.com/analogdevicesinc/openocd" \
    --description "ADI OpenOCD fork (statically built)" \
    --vendor "Analog Devices, Inc." \
    --force \
    -C "$PACKAGE_ROOT" \
    "${mappings[@]}"
}

fpm_wrapper deb
fpm_wrapper rpm

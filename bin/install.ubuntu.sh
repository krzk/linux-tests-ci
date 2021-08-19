#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (c) 2021 Canonical Ltd.
# Author: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
#                             <krzk@kernel.org>
#

set -ex

if [ -z "$ARCH" ]; then
	echo "missing \$ARCH!" >&2
	exit 1
fi

PKGS_CC=""

case "$ARCH" in
	arm) PKGS_CC="gcc-arm-linux-gnueabi";;
	arm64) PKGS_CC="gcc-aarch64-linux-gnu";;
	mips) PKGS_CC="gcc-${CROSS_COMPILE%-}";;
	powerpc) PKGS_CC="gcc-powerpc-linux-gnu";;
	riscv) PKGS_CC="gcc-riscv64-linux-gnu";;
	*) echo "unsupported arch: '$ARCH'!" >&2; exit 1;;
esac

sudo apt update

sudo apt install -y --no-install-recommends build-essential python3-pip libyaml-dev
sudo apt install -y --no-install-recommends $PKGS_CC

echo "Install finished: $0"

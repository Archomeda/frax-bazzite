#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

VERSION="8.055.00"

# Download the driver
cd /tmp
wget -q https://github.com/mtorromeo/r8168/archive/refs/tags/${VERSION}.tar.gz -O r8168.tar.gz
tar xf r8168.tar.gz
cd r8168-${VERSION}

# Detect target kernel source directory (from the image, not host)
pushd /usr/src/kernels
KERNEL=$(ls -d * | head -n1)
popd
KERNELDIR="/lib/modules/${KERNEL}/build"
echo "Building r8168 against kernel: ${KERNEL}"
ls -la /lib/modules

# Build
cd src
make KERNELDIR="${KERNELDIR}" all

rm -rf /tmp/r8168.tar.gz /tmp/r8168-${VERSION}

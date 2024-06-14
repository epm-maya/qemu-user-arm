#!/bin/bash
set -euxo pipefail

rm -rf qemu-user-arm
rm -rf package

rm -f qemu-user-static.tar.zst

if test ! -f qemu-user-static.tar.zst; then
    curl -vLR https://archlinux.org/packages/extra/x86_64/qemu-user-static/download/ -o qemu-user-static.tar.zst
fi

mkdir package
tar xa -C package -f qemu-user-static.tar.zst

mkdir -p qemu-user-arm/usr/local/bin
cp package/usr/bin/qemu-aarch64-static qemu-user-arm/usr/local/bin/
cp -r package/usr/share qemu-user-arm/usr/

tar ca --numeric-owner -f qemu-user-arm.tar.gz qemu-user-arm

tar taf qemu-user-arm.tar.gz

sha256sum qemu-user-arm.tar.gz > qemu-user-arm.tar.gz.sha256

cat qemu-user-arm.tar.gz.sha256

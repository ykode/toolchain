#!/bin/sh

set -e

wget https://s3-ap-southeast-1.amazonaws.com/toolchain.ykode.id/kernel/ti-linux-kernel-3.12.46.tar.gz
git clone https://github.com/crosstool-ng/crosstool-ng

cd crosstool-ng && ./bootstrap && ./configure --enable-local && make && cd ..

mkdir src 
mkdir ct-build
cp devkit8000/devkit8000.ctconfig ct-build/.config 
cd ct-build && ../crosstool-ng/ct-ng source
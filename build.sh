#!/bin/sh

set -e

echo "Current Directory = $(pwd)"
echo "Downloading kernel for Devkit8000..."
wget --quiet https://s3-ap-southeast-1.amazonaws.com/toolchain.ykode.id/kernel/ti-linux-kernel-3.12.46.tar.gz
mv ti-linux-kernel-3.12.46.tar.gz ${HOME}/
git clone https://github.com/crosstool-ng/crosstool-ng

cd crosstool-ng && ./bootstrap && ./configure --enable-local && make && cd ..

mkdir src 
mkdir ct-build
cp devkit8000/devkit8000.ctconfig ct-build/.config 
cd ct-build && ../crosstool-ng/ct-ng source && ../crosstool-ng/ct-ng build && cd ..

tar cvf arm-yk-linux-gnueabihf.tar x-tools && xz -9 arm-yk-linux-gnueabihf.txz 
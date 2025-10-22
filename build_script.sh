#!/bin/bash

## DEVICE STUFF
DEVICE_MODEL="$1"
ARGS="$*"

# Enviorment Variables
SRC_DIR="$(pwd)"
TC_DIR="$HOME/toolchains/neutron-clang"
JOBS="$(nproc --all)"
MAKE_PARAMS="-j$JOBS -C $SRC_DIR O=$SRC_DIR/out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- LLVM=1 CROSS_COMPILE=$TC_DIR/bin/aarch64-linux-gnu-"
export PATH="$TC_DIR/bin:$PATH"

DEFCONFIG=gta7lite_defconfig

toolchaincheck() {
    if [ -d "$TC_DIR" ]; then
        echo "Neutron Clang is already there"
        echo "Credits to dakkshesh07"
    else
        echo "Fetching Neutron Clang with antman script"
        echo "Credits to dakkshesh07"
        mkdir -p "$HOME/toolchains/neutron-clang"; cd "$HOME/toolchains/neutron-clang"; curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"; chmod +x antman; ./antman -S
        cd $SRC_DIR
    fi
}

echo "- Starting Building ..."
make $MAKE_PARAMS $DEFCONFIG
make $MAKE_PARAMS

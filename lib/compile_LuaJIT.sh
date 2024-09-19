#!/bin/bash

# compile LuaJIT for universal .a

PWD=$(pwd)
DIR=$(dirname "$0")

cd $DIR/LuaJIT

export MACOSX_DEPLOYMENT_TARGET=14.0

# x86_64
arch=x86_64
export CPPFLAGS="-arch ${arch}"
export CC="clang -arch ${arch}"
export LDFLAGS="-arch ${arch}"
jit_flags="-arch ${arch}"
make clean
make -j$(sysctl -n hw.logicalcpu) "PREFIX=$dir/install" \
      "CFLAGS=$jit_flags" "HOST_CFLAGS=$jit_flags" \
      "TARGET_CFLAGS=$jit_flags" BUILD_MODE=static \
      CCDEBUG=-g

cp src/libluajit.a ../libluajit_x86_64.a

# arm64
arch=arm64
export CPPFLAGS="-arch ${arch}"
export CC="clang -arch ${arch}"
export LDFLAGS="-arch ${arch} -g"
export CFLAGS=-g
export MYLDFLAGS=-g
jit_flags="-arch ${arch}"
make clean
make -j$(sysctl -n hw.logicalcpu) "PREFIX=$dir/install" \
      "CFLAGS=$jit_flags" "HOST_CFLAGS=$jit_flags" \
      "TARGET_CFLAGS=$jit_flags" BUILD_MODE=static \
      CCDEBUG=-g

cp src/libluajit.a ../libluajit_arm64.a

# join

cd ..

lipo -create -output libluajit.a libluajit_arm64.a libluajit_x86_64.a

cd $PWD

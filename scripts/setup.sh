#! /usr/bin/env bash
cd /intro2llvm/llvm-tutor
mkdir build
cd build
# build all the examples
cmake -DLT_LLVM_INSTALL_DIR=$LLVM_DIR ../
make
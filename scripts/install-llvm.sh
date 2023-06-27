#! /usr/bin/env bash

LLVM_VERSION=$1

export CC=gcc
export CXX=g++

wget "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-project-${LLVM_VERSION}.src.tar.xz" || { echo 'Error downloading LLVM version ${LLVM_VERSION}' ; exit 1; }
tar xf llvm-project-${LLVM_VERSION}.src.tar.xz && rm llvm-project-${LLVM_VERSION}.src.tar.xz

cd llvm-project-${LLVM_VERSION}.src
mkdir build && cd build

# # Build and install LLVM:
cmake ../llvm \
    -G "Unix Makefiles" \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    || { echo 'Error running CMake for LLVM' ; exit 1; }
make -j$(nproc) || { echo 'Error building LLVM' ; exit 1; }
make install || { echo 'Error installing LLVM' ; exit 1; }

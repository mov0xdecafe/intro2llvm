FROM ubuntu:22.04

ARG LLVM_VERSION=16

# LLVM dependencies:

RUN apt update
RUN apt install -y  build-essential \
                    autoconf \
                    automake \
                    cmake \
                    curl \
                    gnupg \
                    libcurl4-openssl-dev \
                    libxml2-dev \
                    lsb-release \
                    make \
                    musl-dev \
                    ncurses-dev \
                    python3 \
                    software-properties-common \
                    wget \
                    zlib1g-dev

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-add-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main"
RUN apt update
RUN apt install -y llvm-16 llvm-16-dev llvm-16-tools clang-16

COPY llvm-tutor /intro2llvm/llvm-tutor
COPY scripts /intro2llvm/scripts
RUN chmod +x /intro2llvm/scripts/setup.sh

ENV CXX=clang++-16
ENV CC=clang-16
ENV LLVM_DIR=/usr/lib/llvm-16/

RUN /intro2llvm/scripts/setup.sh
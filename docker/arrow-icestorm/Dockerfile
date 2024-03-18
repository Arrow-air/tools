FROM alpine:3.18

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apk update
RUN apk add --no-cache --update bash curl git g++ musl-dev make \
    libftdi1-dev clang bison flex-dev gperf readline-dev \
    gawk tcl-dev libffi-dev eigen-dev \
    graphviz python3 libftdi1-dev gcc-gnat llvm16-dev \
    qt5-qtbase python3-dev boost-dev cmake

# To use VHDL with yosys, require ghdl plugin
RUN git clone https://github.com/ghdl/ghdl.git ghdl
RUN git clone https://github.com/ghdl/ghdl-yosys-plugin ghdl-yosys-plugin

# To use yosys with ice40, require icestorm and nextpnr with ice40 architecture
RUN git clone https://github.com/YosysHQ/yosys.git yosys
RUN git clone https://github.com/YosysHQ/icestorm.git icestorm
RUN git clone https://github.com/YosysHQ/nextpnr nextpnr

# Install all
RUN cd yosys; make -j$(nproc); make install
RUN cd ghdl; ./configure --with-llvm-config --prefix=/usr/local; make -j$(nproc); make install
RUN cd ghdl-yosys-plugin; make -j$(nproc); make install
RUN cd icestorm; make -j$(nproc); make install
RUN cd nextpnr; \
    git submodule init && git submodule update; \
    cmake . -DARCH=ice40 -DUSE_IPO=off -DCMAKE_INSTALL_PREFIX=/usr/local; \
    make -j$(nproc); \
    make install

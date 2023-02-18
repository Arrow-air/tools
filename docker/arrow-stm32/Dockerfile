FROM ubuntu:lunar

RUN apt-get update && \
    apt-get clean && \
    apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    stlink-tools \
    cmake

ENV STM32_LIB_PATH=/home/stm32/lib/
ENV ARM_WEBSITE https://developer.arm.com/-/media/Files/downloads/gnu-rm/
ENV ARM_RELEASE=10.3-2021.10
WORKDIR ${STM32_LIB_PATH}

RUN git clone --depth=1 https://github.com/STMicroelectronics/STM32CubeF4
RUN git clone --depth=1 https://github.com/STMicroelectronics/STM32CubeH7
RUN git clone https://github.com/ObKo/stm32-cmake

RUN wget -qO- ${ARM_WEBSITE}/${ARM_RELEASE}/gcc-arm-none-eabi-${ARM_RELEASE}-x86_64-linux.tar.bz2 | tar -xj

ENV STM32_CMAKE_PATH=${STM32_LIB_PATH}/stm32-cmake/cmake/
ENV STM32_TOOLCHAIN_PATH=${STM32_LIB_PATH}/gcc-arm-none-eabi-${ARM_RELEASE}/bin
ENV STM32_TARGET_TRIPLET=arm-none-eabi
ENV STM32_CUBE_F4_PATH=${STM32_LIB_PATH}/STM32CubeF4
ENV STM32_CUBE_H7_PATH=${STM32_LIB_PATH}/STM32CubeH7

WORKDIR /usr/src/app

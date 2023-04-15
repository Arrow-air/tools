# Allow C and Rust STM32 Development
FROM ghcr.io/arrow-air/tools/arrow-rust:1.1

RUN apk add --no-cache \
    wget \
    curl \
    libusb-dev \
    udev \
    stlink \
    gcc \
    g++ \
    newlib-arm-none-eabi \
    cmake

ENV STM32_LIB_PATH=/home/stm32/lib/
WORKDIR ${STM32_LIB_PATH}

RUN git clone --depth=1 https://github.com/STMicroelectronics/STM32CubeF4
RUN git clone --depth=1 https://github.com/STMicroelectronics/STM32CubeH7
RUN git clone https://github.com/ObKo/stm32-cmake

ENV STM32_CMAKE_PATH=${STM32_LIB_PATH}/stm32-cmake/cmake/
ENV STM32_TOOLCHAIN_PATH=/usr/bin/
ENV STM32_TARGET_TRIPLET=arm-none-eabi
ENV STM32_CUBE_F4_PATH=${STM32_LIB_PATH}/STM32CubeF4
ENV STM32_CUBE_H7_PATH=${STM32_LIB_PATH}/STM32CubeH7
ENV PATH=$PATH:${STM32_TOOLCHAIN_PATH}

RUN ln -s /usr/bin/make /usr/bin/gmake
WORKDIR /usr/src/app

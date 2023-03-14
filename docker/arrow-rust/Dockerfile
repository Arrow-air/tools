FROM rust:1.68-alpine

ARG TARGETOS
ARG TARGETARCH

ENV BUILDX_ARCH="${TARGETOS:-linux}-${TARGETARCH:-amd64}"
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN echo "Building for $BUILDX_ARCH"

RUN apk add --no-cache musl-dev libc-dev pkgconfig openssl \
    protoc protobuf-dev openssl-dev git perl make && \
    # Add rust dependencies
    rustup target add x86_64-unknown-linux-musl && \
    rustup component add clippy && \
    rustup component add rustfmt

ENV RUSTFLAGS="-Ctarget-feature=-crt-static"
RUN cargo install cargo-tarpaulin
ENV RUSTFLAGS=

WORKDIR /usr/src/app

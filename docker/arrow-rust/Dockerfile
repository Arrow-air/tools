FROM rust:1.65-alpine3.16

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN apk add --no-cache musl-dev libc-dev pkgconfig openssl protoc protobuf-dev openssl-dev git && \
    # Add rust dependencies
    rustup target add x86_64-unknown-linux-musl && \
    rustup component add clippy && \
    rustup component add rustfmt

WORKDIR /usr/src/app

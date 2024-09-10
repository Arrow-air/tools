FROM rust:1.81-alpine

ARG TARGETOS
ARG TARGETARCH

ENV BUILDX_ARCH="${TARGETOS:-linux}-${TARGETARCH:-amd64}"
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    OPENSSL_DIR=/usr

RUN echo "Building for $BUILDX_ARCH"

RUN apk add --no-cache musl-dev libc-dev pkgconfig openssl \
    protoc protobuf-dev openssl-dev git perl make && \
    # Check target architecture
    if [ "$BUILDX_ARCH" = "linux-arm64" ]; then ARCHITECTURE=aarch64-unknown-linux-musl; else ARCHITECTURE=x86_64-unknown-linux-musl; fi && \
    # Add rust dependencies
    rustup target add ${ARCHITECTURE} && \
    rustup component add clippy && \
    rustup component add rustfmt && \
    # Use binary install for tarpaulin to bypass build OOM error
    wget https://github.com/xd009642/tarpaulin/releases/download/0.31.2/cargo-tarpaulin-${ARCHITECTURE}.tar.gz && \
    tar axvf cargo-tarpaulin-${ARCHITECTURE}.tar.gz && \
    mv cargo-tarpaulin $CARGO_HOME/bin/ && \
    rm cargo-tarpaulin-${ARCHITECTURE}.tar.gz

WORKDIR /usr/src/app

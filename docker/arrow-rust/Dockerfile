FROM rust:1.63-alpine3.16 AS taplo-build

ARG TAPLO_VERSION=0.7.0

WORKDIR /build

RUN apk add --no-cache musl-dev && \
    wget https://github.com/tamasfe/taplo/archive/refs/tags/release-taplo-cli-$TAPLO_VERSION.tar.gz && \
    tar axvf release-taplo-cli-$TAPLO_VERSION.tar.gz && \
    cd taplo-release-taplo-cli-$TAPLO_VERSION && \
    cargo build -p taplo-cli --release && \
    cd .. && \
    mv taplo-release-taplo-cli-$TAPLO_VERSION/target/release/taplo . && \
    rm -rf taplo-release-taplo-cli-$TAPLO_VERSION

FROM rust:1.63-alpine3.16

ARG FLAKE8_VERSION=5.0.4

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY --from=taplo-build /build/taplo /usr/bin/taplo

RUN apk add --no-cache musl-dev libc-dev py3-pip pkgconfig openssl protoc protobuf-dev openssl-dev git npm && \
    # Add python dependencies
    pip install flake8==$FLAKE8_VERSION && \
    pip install flake8-bugbear && \
    pip install flake8-black && \
    pip install yapf && \
    # Add cspell dependencies
    npm install -g cspell && \
    npm install -g @cspell/dict-rust && \
    cspell link add @cspell/dict-rust && \
    # Add rust dependencies
    rustup target add x86_64-unknown-linux-musl && \
    rustup component add clippy && \
    rustup component add rustfmt && \
    # Add eclint
    npm install -g eclint
WORKDIR /usr/src/app

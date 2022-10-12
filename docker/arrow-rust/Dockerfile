FROM tamasfe/taplo:0.7.0-alpine AS taplo

FROM rust:1.63-alpine3.16

ARG FLAKE8_VERSION=5.0.4

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY --from=taplo /usr/bin/taplo /usr/bin/taplo

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

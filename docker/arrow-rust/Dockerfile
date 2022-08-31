FROM rust:1.61-alpine3.16

ARG FLAKE8_VERSION=5.0.4

ENV RUSTUP_HOME=/usr/local/rustup \
	CARGO_HOME=/usr/local/cargo \
	PATH=/usr/local/cargo/bin:$PATH

RUN apk add --no-cache musl-dev libc-dev py3-pip pkgconfig openssl openssl-dev git && \
	pip install flake8==$FLAKE8_VERSION && \
	pip install yapf && \
	rustup target add x86_64-unknown-linux-musl && \
	rustup component add clippy && \
	rustup component add rustfmt && \
	# Taplo currenlty doesn't have a working docker, we have to build the latest code from the master branch for now
	# see: https://github.com/tamasfe/taplo/issues/305
	cargo install --target x86_64-unknown-linux-musl taplo-cli --locked && \
	git clone https://github.com/tamasfe/taplo.git && \
	cd taplo && \
	cargo build -p taplo-cli --release --target x86_64-unknown-linux-musl && \
	cp target/x86_64-unknown-linux-musl/release/taplo /usr/local/cargo/bin/taplo && \
	cd .. && \
	rm -rf taplo

WORKDIR /usr/src/app

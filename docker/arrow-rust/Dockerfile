FROM rust:alpine as rust

FROM tamasfe/taplo as taplo

FROM python:3-alpine as python

ARG FLAKE8_VERSION=5.0.4

COPY --from=rust /usr/local/rustup /usr/local/rustup
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=taplo /usr/bin/taplo /usr/bin/taplo

ENV RUSTUP_HOME=/usr/local/rustup \
	CARGO_HOME=/usr/local/cargo \
	PATH=/usr/local/cargo/bin:$PATH

RUN apk add --no-cache gcc libc-dev && \
	pip install flake8==$FLAKE8_VERSION && \
	pip install yapf && \
	rustup component add clippy && \
	rustup component add rustfmt

WORKDIR /usr/src/app

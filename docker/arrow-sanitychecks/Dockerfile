FROM tamasfe/taplo:0.7.0-alpine AS taplo

FROM --platform=$TARGETPLATFORM rust:1.63-alpine3.16

ARG FLAKE8_VERSION=5.0.4

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY --from=taplo /usr/bin/taplo /usr/bin/taplo

RUN apk add --no-cache py3-pip openssl npm git && \
    # Add python dependencies
    pip install flake8==$FLAKE8_VERSION && \
    pip install flake8-bugbear && \
    pip install flake8-black && \
    pip install yapf && \
    # Add cspell dependencies
    npm install -g cspell && \
    npm install -g @cspell/dict-rust && \
    cspell link add @cspell/dict-rust && \
    # Add eclint
    npm install -g eclint && \
    # Add commitlint for git commit message validations
    npm install -g @commitlint/config-conventional && \
    npm install -g @commitlint/cli && \
    # Add lintspaces for javascript and css files
    npm install -g lintspaces-cli

WORKDIR /usr/src/app

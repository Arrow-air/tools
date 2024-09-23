FROM tamasfe/taplo:0.9.3-alpine AS taplo

FROM rust:1.81-alpine

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

COPY --from=taplo /usr/bin/taplo /usr/bin/taplo
COPY ./release_checklist.py /usr/bin/release_checklist.py

RUN apk add --no-cache py3-pip py3-autopep8 py3-pycodestyle openssl npm git && \
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

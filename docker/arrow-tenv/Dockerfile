FROM alpine:latest

ARG TARGETOS
ARG TARGETARCH

ENV TENV_VERSION=1.2.0
ENV TOFU_VERSION=1.6.2
ENV TENV_AUTO_INSTALL=true
ENV USER=tenv
ENV PATH "/home/$USER/.tenv:$PATH"

RUN apk add --no-cache bash curl git cosign

RUN adduser -D "$USER"
USER "$USER"

RUN cd ~ && mkdir .tenv && cd .tenv && \
    wget -O tenv-${TENV_VERSION}.tar.gz https://github.com/tofuutils/tenv/releases/download/v${TENV_VERSION}/$(if [ "$TARGETARCH" == 'amd64' ] ; then echo "tenv_v${TENV_VERSION}_Linux_x86_64" ; else echo "tenv_v${TENV_VERSION}_Linux_$TARGETARCH" ; fi).tar.gz && \
    tar axvf tenv-${TENV_VERSION}.tar.gz && \
    rm tenv-${TENV_VERSION}.tar.gz && \
    tenv install $TOFU_VERSION

SHELL ["/bin/bash"]
ENTRYPOINT ["tofu"]

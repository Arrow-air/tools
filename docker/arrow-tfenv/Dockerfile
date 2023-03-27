FROM alpine:latest

ENV TFENV_VERSION=3.0.0
ENV TERRAFORM_VERSION=1.4.2
ENV TFENV_AUTO_INSTALL=true
ENV USER=tfenv
ENV PATH "/home/$USER/.tfenv/bin:$PATH"

RUN apk add --no-cache bash curl git

RUN adduser -D "$USER"
USER "$USER"

RUN cd ~ && mkdir .tfenv && \
    wget -O tfenv-${TFENV_VERSION}.tar.gz https://github.com/tfutils/tfenv/archive/refs/tags/v${TFENV_VERSION}.tar.gz && \
    tar axvf tfenv-${TFENV_VERSION}.tar.gz && \
    mv tfenv-${TFENV_VERSION}/* ~/.tfenv/ && \
    rm tfenv-${TFENV_VERSION}.tar.gz && \
    rm -rf tfenv-${TFENV_VERSION} && \
    tfenv install $TERRAFORM_VERSION

SHELL ["/bin/bash"]
ENTRYPOINT ["terraform"]

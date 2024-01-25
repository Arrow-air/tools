FROM postgis/postgis:13-3.3-alpine
RUN apk add --no-cache \
    cmake \
    make \
    g++ \
    boost-dev \
    git \
    postgresql-dev \
    perl \
    openssl \
    openssl-dev \
    sfcgal-dev

RUN wget -O pgrouting.tar.gz https://github.com/pgRouting/pgrouting/archive/v3.1.4.tar.gz
RUN tar -xvzf pgrouting.tar.gz
RUN cd pgrouting-* \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd ../.. \
    && rm -rf pgrouting*

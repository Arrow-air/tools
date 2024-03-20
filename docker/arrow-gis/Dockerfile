FROM postgis/postgis:15-3.3-alpine
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

RUN wget -O pgrouting-3.5.0.tar.gz https://github.com/pgRouting/pgrouting/archive/v3.5.0.tar.gz \
    && tar -xvzf pgrouting-3.5.0.tar.gz \
    && cd pgrouting-* \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd ../.. \
    && rm -rf pgrouting*

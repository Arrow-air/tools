FROM postgis/postgis:13-3.3-alpine
RUN apk add --no-cache --virtual .build-deps \
    cmake \
    make \
    g++ \
    boost-dev \
    git \
    postgresql-dev \
    perl

RUN wget -O pgrouting.tar.gz https://github.com/pgRouting/pgrouting/archive/v3.1.4.tar.gz
RUN tar -xvzf pgrouting.tar.gz
RUN cd pgrouting \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && cd ../.. \
    && rm -rf pgrouting* \
    && apk del .build-deps

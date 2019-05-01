FROM alpine:edge
LABEL maintainer="Luka Dornhecker <luka.dornhecker@gmail.com>"

ENV LUA_VERSION 5.1.5
ENV LUAJIT_VERSION 2.0.5
ENV LUAROCKS_VERSION 3.0.4
ENV BUTLER_VERSION 15.12.0
ENV LOVE_VERSION 11.2
ENV LOVE_RELEASE_VERSION 2.0.11

RUN apk add --no-cache \
        curl \
        gcc \
        git \
        libzip \
        libzip-dev \
        libc-dev \
        make \
        ncurses \
        ncurses-dev \
        openssl \
        readline-dev \
        unzip \
        wget \
        zip \
        fakeroot \
        dpkg

RUN wget https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz -O - | tar -xzf - && \
        cd lua-$LUA_VERSION && \
        make -j"$(nproc)" linux && \
        make install && \
        cd .. && \
        rm -rf lua-${LUA_VERSION}

RUN wget https://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz -O - \
        | tar -xzf - && \
        cd luarocks-$LUAROCKS_VERSION && \
        ./configure && \
        make -j"$(nproc)" && \
        make install && \
        cd .. && \
        rm -rf luarocks-$LUAROCKS_VERSION

RUN wget http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz -O - | tar -xzf - && \
        cd LuaJIT-$LUAJIT_VERSION && \
        make && \
        make install && \
        cd .. && \
        rm -rf LuaJIT-$LUAJIT_VERSION

RUN luarocks install --server=http://luarocks.org/dev love-release $LOVE_RELEASE_VERSION

COPY . /snek

WORKDIR /snek

RUN love-release -M -W64

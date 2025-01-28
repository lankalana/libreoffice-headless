FROM --platform=$BUILDPLATFORM alpine:3.9 AS repo-download
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG LIBRE_URL=https://downloadarchive.documentfoundation.org/libreoffice/old/7.6.7.2/src/libreoffice-7.6.7.2.tar.xz
WORKDIR /app
ADD $LIBRE_URL libre.tar.xz
RUN mkdir libre && tar -xJf libre.tar.xz -C ./libre --strip-components=1

FROM debian:12 AS builder
WORKDIR /app
COPY --from=repo-download /app/libre .

RUN apt update \
	&& apt install -y git build-essential zip ccache junit4 libkrb5-dev nasm graphviz python3 python3-dev python3-setuptools qtbase5-dev libkf5coreaddons-dev libkf5i18n-dev libkf5config-dev libkf5windowsystem-dev libkf5kio-dev libqt5x11extras5-dev autoconf libcups2-dev libfontconfig1-dev gperf libxslt1-dev xsltproc libxml2-utils libxrandr-dev libx11-dev bison flex libgtk-3-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev ant ant-optional libnss3-dev libavahi-client-dev libxt-dev \
	&& apt clean

RUN ./autogen.sh --disable-dependency-tracking --disable-gui --disable-gdb-index --disable-xmlhelp --without-java --disable-postgresql-sdbc --with-galleries=no --without-system-fontconfig --with-theme="breeze_dark" --enable-release-build --enable-lto --enable-optimized=yes --without-package-format

RUN make

FROM scratch
WORKDIR /
COPY --from=builder /app/instdir /libreoffice
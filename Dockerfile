FROM scratch
WORKDIR /
# libre-amd64 or libre-arm64
ARG TARGETARCH
COPY /libre-$TARGETARCH /libreoffice

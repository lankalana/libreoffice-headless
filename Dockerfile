FROM scratch
WORKDIR /
# libre-amd64 or libre-arm64
COPY /libre-$BUILDARCH /libreoffice
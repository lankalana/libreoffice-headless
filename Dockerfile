FROM scratch
WORKDIR /
# libre-amd64 or libre-arm64
ARG TARGETARCH
COPY --from=libre-$TARGETARCH /libreoffice /libreoffice
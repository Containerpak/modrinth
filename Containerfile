FROM ubuntu:26.04 AS source

ADD --checksum=sha256:48a92aaeae7654ca92153ad972bc067bff6ac04f8bed9faae43d8531c7bebeff https://github.com/modrinth/code/releases/download/v0.19.2/Modrinth.App_0.19.2_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

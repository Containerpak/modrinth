FROM ubuntu:26.04 AS source

ADD --checksum=sha256:28d9779b49799abca0a3cd8869a551460e574009d5dbb755da4c3a599f30678b https://github.com/modrinth/code/releases/download/v0.20.0/Modrinth.App_0.20.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

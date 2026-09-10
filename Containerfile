FROM ubuntu:26.04 AS source

ADD --checksum=sha256:3829b0c8f7d417c7426642f53aa2c76db27f9d1e8c687d4e79027f4c1e39fe7e https://github.com/modrinth/code/releases/download/v0.20.1/Modrinth.App_0.20.1_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

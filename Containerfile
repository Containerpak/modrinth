FROM ubuntu:26.04 AS source

ADD --checksum=sha256:eb3e5da0be62a33006fbd28d273c3dfb68de90de62d8781f4b507bd07d18ed00 https://github.com/modrinth/code/releases/download/v0.21.2/Modrinth.App_0.21.2_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

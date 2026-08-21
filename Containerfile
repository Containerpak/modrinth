FROM ubuntu:26.04 AS source

ADD --checksum=sha256:9785c2dcddcc4bbe09bea2ca204d6d7abc05b5d8868bf5175c9f3d9fc9b7afa8 https://github.com/modrinth/code/releases/download/v0.18.2/Modrinth.App_0.18.2_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

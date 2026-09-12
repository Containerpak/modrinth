FROM ubuntu:26.04 AS source

ADD --checksum=sha256:f9fa9b0a4306e07473e8cb3ba0b234606b0b2f698c4cf52f11411ab8cbe4f699 https://github.com/modrinth/code/releases/download/v0.20.4/Modrinth.App_0.20.4_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

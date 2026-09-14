FROM ubuntu:26.04 AS source

ADD --checksum=sha256:ec345321e87110d1be5f4f13583c8314832e36054bd356e2241994214a80ee7e https://github.com/modrinth/code/releases/download/v0.20.5/Modrinth.App_0.20.5_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

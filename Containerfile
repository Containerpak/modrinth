FROM ubuntu:26.04 AS source

ADD --checksum=sha256:00cae977a8679b2edab7bba904441bbea394f0776fe5f0aed803e664218ded98 https://github.com/modrinth/code/releases/download/v0.19.1/Modrinth.App_0.19.1_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

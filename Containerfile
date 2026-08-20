FROM ubuntu:26.04 AS source

ADD --checksum=sha256:93664a0d250dab7f6f6b79a972584e94e2c09496ca2205161ea0d6ea54c27717 https://github.com/modrinth/code/releases/download/v0.18.0/Modrinth.App_0.18.0_amd64.deb /tmp/source

FROM ghcr.io/containerpak/webkitgtk:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/modrinth.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/modrinth.deb && \
    cpak-clean-junk

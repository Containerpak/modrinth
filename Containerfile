FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:ba51a433163797c632ea22da10f85eff3d4d58076e0a33dfbbd84da246656175 https://github.com/modrinth/code/releases/download/v0.17.5/Modrinth.App_0.17.5_amd64.deb /tmp/source
COPY icon.png /usr/share/icons/hicolor/128x128/apps/modrinth.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libgtk-3-0 libwebkit2gtk-4.1-0 && \
    dpkg-deb -x /tmp/source / && \
    cpak-clean-junk

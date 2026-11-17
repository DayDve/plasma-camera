# Build environment: the same Qt/KF6 versions as the target system (Debian forky).
FROM debian:forky-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
      cmake g++ make extra-cmake-modules gettext pkgconf \
      qt6-base-dev qt6-declarative-dev qt6-tools-dev \
      libkirigami-dev kirigami-addons-dev libkf6config-dev libkf6coreaddons-dev libkf6i18n-dev \
      qt6-multimedia-dev qt6-sensors-dev libexiv2-dev libcamera-dev \
    && rm -rf /var/lib/apt/lists/*
ENV LANG=C.UTF-8

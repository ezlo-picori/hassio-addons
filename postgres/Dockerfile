# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache \
    postgresql14 && \
    mkdir /run/postgresql && \
    chown postgres:postgres /run/postgresql

# Copy root filesystem
COPY rootfs /

WORKDIR /

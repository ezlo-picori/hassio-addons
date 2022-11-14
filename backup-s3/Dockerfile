ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# add aws-cli and deps
RUN apk add --no-cache \
    py3-pip && \
    pip3 install awscli awscli-plugin-endpoint

# Copy root filesystem
COPY rootfs /
WORKDIR /

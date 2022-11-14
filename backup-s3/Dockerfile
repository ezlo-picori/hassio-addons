ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# add aws-cli and deps
RUN apk add --no-cache aws-cli && \
    apk add --no-cache --virtual .pip py3-pip && \
    pip3 install --no-cache-dir awscli-plugin-endpoint && \
    apk del .pip

# Copy root filesystem
COPY rootfs /
WORKDIR /

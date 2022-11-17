ARG BUILD_FROM
FROM $BUILD_FROM

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
        gcc g++ git gpgv pwgen python3 py3-babel py3-cssselect \
        py3-dateutil py3-html2text py3-lxml py3-pillow py3-pip \
        py3-requests py3-six py3-unidecode py3-yaml py3-wheel \
        make nodejs npm && \
    npm install --production -g kresus@0.18.1 && \
    addgroup kresus && \
    adduser -G kresus -D -h /home/kresus kresus && \
    mkdir -p /woob && \
    chown kresus:kresus /woob && \
    chown -R kresus:kresus /etc/kresus && \
    chmod 0400 /etc/kresus/config.ini && \
    chmod 0755 /etc/kresus

ENV KRESUS_DIR="/data/kresus"
ENV KRESUS_USER="kresus"

WORKDIR /

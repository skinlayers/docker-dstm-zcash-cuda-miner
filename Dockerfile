FROM alpine:latest as dstm-downloader

ARG VERSION=0.6.1
ARG ARCHIVE_DIR=zm_$VERSION
ARG ARCHIVE_FILE=$ARCHIVE_DIR.tar.gz
ARG ARCHIVE_FILE_ID=1JKeBTJshILqYpHiu7qRhjvcRhaa4NC5W
ARG ARCHIVE_URL=https://docs.google.com/uc?export=download&id=$ARCHIVE_FILE_ID
ARG ARCHIVE_SHA256=0de3685e41e34c1bafe3b14762d99a4720663f9553e1bbb88aa81f377b867a4f
ARG ARCHIVE_SHA256_FILE=$ARCHIVE_FILE-sha256.txt

RUN set -eu && \
    apk add --update curl && \
    curl -L "$ARCHIVE_URL" -o "$ARCHIVE_FILE" && \
    echo "$ARCHIVE_SHA256  $ARCHIVE_FILE" > "$ARCHIVE_SHA256_FILE" && \
    sha256sum -c "$ARCHIVE_SHA256_FILE" && \
    tar xf "$ARCHIVE_FILE" --strip 1 "$ARCHIVE_DIR/zm"

FROM nvidia/cuda:9.0-base-ubuntu16.04
LABEL maintainer="skinlayers@gmail.com"

ARG RUNTIME_DEPENDENCIES=" \
    openssl \
"

RUN set -eu && \
    adduser --system --home /data --uid 400 --group miner && \
    apt-get update && \
    apt-get -y install $RUNTIME_DEPENDENCIES && \
    rm -r /var/lib/apt/lists/*

COPY --from=dstm-downloader /zm /usr/local/bin
COPY ./docker-entrypoint.sh /

RUN chmod 0755 /docker-entrypoint.sh

EXPOSE 2222

USER miner

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/zm"]

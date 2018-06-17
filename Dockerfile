FROM nvidia/cuda:9.0-base-ubuntu16.04
LABEL maintainer="skinlayers@gmail.com"

ARG VERSION=0.6.1
ARG ARCHIVE_DIR=zm_$VERSION
ARG ARCHIVE_FILE=$ARCHIVE_DIR.tar.gz
ARG ARCHIVE_FILE_ID=1JKeBTJshILqYpHiu7qRhjvcRhaa4NC5W
ARG ARCHIVE_URL=https://docs.google.com/uc?export=download&id=$ARCHIVE_FILE_ID
ARG ARCHIVE_SHA1=6315de430b97b2960d6247b372481d2e24f58692
ARG ARCHIVE_SHA1_FILE=${ARCHIVE_FILE}-sha1.txt
ARG BUILD_DEPENDENCIES=" \
    curl \
    ca-certificates \
"
ARG RUNTIME_DEPENDENCIES=" \
    openssl \
"

RUN set -eu && \
    adduser --system --home /data --uid 400 --group miner && \
    apt-get update && \
    apt-get -y install --no-install-recommends $BUILD_DEPENDENCIES && \
    curl -L "$ARCHIVE_URL" -o "$ARCHIVE_FILE" && \
    echo "$ARCHIVE_SHA1  $ARCHIVE_FILE" > "$ARCHIVE_SHA1_FILE" && \
    sha1sum -c "$ARCHIVE_SHA1_FILE" && \
    tar xf "$ARCHIVE_FILE" --strip 1 "$ARCHIVE_DIR/zm" && \
    mv zm /usr/local/bin && \
    rm -r \
        "$ARCHIVE_FILE" \
        "$ARCHIVE_SHA1_FILE" \
    && \
    apt-mark manual $RUNTIME_DEPENDENCIES && \
    apt-get remove --purge -y --auto-remove $BUILD_DEPENDENCIES $(apt-mark showauto) && \
    apt-get -y install $RUNTIME_DEPENDENCIES && \
    rm -r /var/lib/apt/lists/*

COPY ./docker-entrypoint.sh /

RUN chmod 0755 /docker-entrypoint.sh

EXPOSE 2222

USER miner

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/zm"]

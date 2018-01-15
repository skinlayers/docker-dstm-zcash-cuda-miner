FROM nvidia/cuda:9.0-base-ubuntu16.04
LABEL maintainer="skinlayers@gmail.com"

ARG VERSION=0.5.8
ARG ARCHIVE_DIR=zm_${VERSION}
ARG ARCHIVE_FILE=${ARCHIVE_DIR}.tar.gz
ARG ARCHIVE_URL=https://docs.google.com/uc?export=download&id=19fSFYqoeOhOkxQqKnGpNI3n-7TIppHnq
ARG ARCHIVE_SHA256=528dfa15db6ad5689bb049141f79ccd00209f4b74fdc942ff28ee89a284afa12
ARG ARCHIVE_SHA256_FILE=${ARCHIVE_FILE}_sha256.txt

WORKDIR /usr/local/bin
RUN set -eu && \
    adduser --system --home /data --group miner && \
    BUILD_DEPENDENCIES=" \
        curl \
        ca-certificates \
    "; \
    RUNTIME_DEPENDENCIES=" \
        openssl \
    "; \
    apt-get update && apt-get -y install --no-install-recommends $BUILD_DEPENDENCIES && \
    curl -L "$ARCHIVE_URL" -o "$ARCHIVE_FILE" && \
    echo "$ARCHIVE_SHA256  $ARCHIVE_FILE" > "$ARCHIVE_SHA256_FILE" && \
    sha256sum -c "$ARCHIVE_SHA256_FILE" && \
    tar xf "$ARCHIVE_FILE" && \
    mv "${ARCHIVE_DIR}/zm" /usr/local/bin && \
    rm -r \
        "$ARCHIVE_FILE" \
        "$ARCHIVE_DIR" \
        "$ARCHIVE_SHA256_FILE" \
    && \
    apt-mark manual $RUNTIME_DEPENDENCIES && \
    apt-get remove --purge -y --auto-remove $BUILD_DEPENDENCIES $(apt-mark showauto) && \
    apt-get -y install $RUNTIME_DEPENDENCIES && \
    rm -r /var/lib/apt/lists/*

ENV GPU_FORCE_64BIT_PTR 0
ENV GPU_MAX_HEAP_SIZE 100
ENV GPU_USE_SYNC_OBJECTS 1
ENV GPU_MAX_ALLOC_PERCENT 100
ENV GPU_SINGLE_ALLOC_PERCENT 100

COPY ./docker-entrypoint.sh /

RUN chmod 0755 /docker-entrypoint.sh

EXPOSE 2222

USER miner

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/bin/zm"]

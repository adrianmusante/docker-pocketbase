ARG POCKETBASE_VERSION=0.29.2
ARG BUILD_DIR=/pb_build
ARG BUILD_TAG
FROM alpine:3 AS base

RUN apk add --no-cache ca-certificates curl


FROM base AS build

RUN apk add --no-cache unzip

ARG POCKETBASE_VERSION
ARG BUILD_DIR
ARG TARGETPLATFORM

RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  PACKAGE_PLATFORM=linux_amd64  ;; \
         "linux/arm64")  PACKAGE_PLATFORM=linux_arm64  ;; \
         "linux/arm/v7") PACKAGE_PLATFORM=linux_armv7  ;; \
    esac \
    && curl -fsSL -o /tmp/pocketbase.zip https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_${PACKAGE_PLATFORM}.zip \
    && unzip /tmp/pocketbase.zip -d $BUILD_DIR/


FROM base AS final

ARG uid=1001
ARG gid=1001
ARG user=pocketbase
ARG group=pocketbase
ARG POCKETBASE_WORKDIR=/pocketbase
ARG POCKETBASE_PORT_NUMBER=8090

ARG POCKETBASE_VERSION
ARG BUILD_DIR

ENV POCKETBASE_VERSION=$POCKETBASE_VERSION \
    POCKETBASE_PORT_NUMBER=$POCKETBASE_PORT_NUMBER \
    POCKETBASE_WORKDIR=$POCKETBASE_WORKDIR \
    POCKETBASE_HOME=/opt/pocketbase

EXPOSE $POCKETBASE_PORT_NUMBER

RUN mkdir -p $POCKETBASE_HOME  \
    && mkdir -p -m 777 "$POCKETBASE_WORKDIR" \
    && addgroup -g ${gid} ${group} \
    && adduser -u ${uid} -G ${group} -s /bin/sh -D ${user}

COPY --from=build $BUILD_DIR $POCKETBASE_HOME
COPY scripts $POCKETBASE_HOME/scripts
RUN chmod -R 755 $POCKETBASE_HOME \
    && ln -s $POCKETBASE_HOME/pocketbase /usr/local/bin/pocketbase

USER $uid
WORKDIR "$POCKETBASE_WORKDIR"

ARG BUILD_TAG
ENV BUILD_TAG="$BUILD_TAG"

ENTRYPOINT ["/opt/pocketbase/scripts/entrypoint.sh"]

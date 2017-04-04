FROM ubuntu:xenial

ENV PROJECT=cinder
ARG DOCKER_REPO=yaodu/openstack-requirements
ARG DOCKER_TAG=ubuntu
ARG WHEELS
ARG PROJECT_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG PROJECT_REF=master
ARG SCRIPTS_REPO=https://github.com/openstack/loci
ARG SCRIPTS_REF=master
ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends python ca-certificates curl git git \
    && mkdir /tmp/common/ \
    && git init /tmp/common/ \
    && git fetch --git-dir /tmp/common/.git/ $SCRIPTS_REPO $SCRIPTS_REF \
    && git checkout --git-dir /tmp/common/.git/ FETCH_HEAD  \
    && /tmp/common/scripts/download.sh \
    && /tmp/common/scripts/install.sh \
    && /tmp/common/scripts/cleanup.sh

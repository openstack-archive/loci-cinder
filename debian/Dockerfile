FROM debian:jessie-slim

ENV PROJECT=cinder
ARG DOCKER_REPO=yaodu/openstack-requirements
ARG DOCKER_TAG=latest
ARG WHEELS
ARG GIT_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG GIT_REF
ARG GIT_REF_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG SCRIPTS_REPO=https://github.com/openstack/loci
ARG SCRIPTS_REF=master
ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends python ca-certificates curl git git \
    && mkdir /tmp/common && cd /tmp/common && git init . && git fetch $SCRIPTS_REPO $SCRIPTS_REF && git checkout FETCH_HEAD && cd / \
    && /tmp/common/scripts/download.sh \
    && /tmp/common/scripts/install.sh \
    && /tmp/common/scripts/cleanup.sh

FROM centos:7

ENV PROJECT=cinder
ARG DOCKER_REPO=yaodu/openstack-requirements
ARG DOCKER_TAG=centos
ARG WHEELS
ARG GIT_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG GIT_REF
ARG GIT_REF_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG SCRIPTS_REPO=https://github.com/openstack/loci
ARG SCRIPTS_REF=master
ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && yum install --setopt=tsflags=nodocs -y python curl git \
    && git init /tmp/common/ \
    && git fetch --git-dir /tmp/common/.git/ $SCRIPTS_REPO $SCRIPTS_REF \
    && git checkout --git-dir /tmp/common/.git/ FETCH_HEAD  \
    && /tmp/common/scripts/download.sh \
    && /tmp/common/scripts/install.sh \
    && /tmp/common/scripts/cleanup.sh

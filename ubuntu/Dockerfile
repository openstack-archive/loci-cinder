FROM ubuntu:xenial

ENV PROJECT=cinder
ARG DOCKER_REPO=yaodu/openstack-requirements
ARG DOCKER_TAG=ubuntu
ARG WHEELS
ARG GIT_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG GIT_REF
ARG GIT_REF_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG SCRIPTS=https://github.com/yaodu/common/archive/0.1.2.tar.gz

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends python ca-certificates curl \
    && curl -sSL $SCRIPTS | tar xz -C /tmp/ --strip-components=2 \
    && /tmp/download.sh $DOCKER_REPO $DOCKER_TAG $WHEELS \
    && /tmp/install.sh $PROJECT $GIT_REPO $GIT_REF_REPO $GIT_REF \
    && /tmp/cleanup.sh

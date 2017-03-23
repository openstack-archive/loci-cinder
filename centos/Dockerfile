FROM centos:7

ENV PROJECT=cinder
ARG DOCKER_REPO=yaodu/openstack-requirements
ARG DOCKER_TAG=centos
ARG WHEELS
ARG GIT_REPO=https://github.com/openstack/${PROJECT}
ARG GIT_REF
ARG GIT_REF_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG SCRIPTS=https://github.com/yaodu/common/archive/0.1.2.tar.gz

RUN set -x \
    && yum install --setopt=tsflags=nodocs -y python curl \
    && curl -sSL $SCRIPTS | tar xz -C /tmp/ --strip-components=2 \
    && /tmp/download.sh $DOCKER_REPO $DOCKER_TAG $WHEELS \
    && /tmp/install.sh $PROJECT $GIT_REPO $GIT_REF_REPO $GIT_REF \
    && /tmp/cleanup.sh

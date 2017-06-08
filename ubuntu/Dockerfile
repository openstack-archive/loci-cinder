FROM ubuntu:xenial

ENV PATH=/var/lib/openstack/bin:$PATH
ENV PROJECT=cinder
ARG WHEELS=openstackloci/requirements:ubuntu
ARG PROJECT_REPO=https://git.openstack.org/openstack/${PROJECT}
ARG PROJECT_REF=master
ARG SCRIPTS_REPO=https://github.com/openstack/loci
ARG SCRIPTS_REF=master
ARG OVERRIDE=override
ENV UBUNTU_MIRROR='' # ubuntu mirror
ENV PYPI_MIRROR='' # pypi mirror
ADD $OVERRIDE /

RUN /bin/bash -c 'if [[ -n ${UBUNTU_MIRROR} ]]; then sed -i 's#http://archive.ubuntu.com#${UBUNTU_MIRROR}#g' /etc/apt/sources.list; fi'
RUN /bin/bash -c 'if [[ -n ${PYPI_MIRROR} ]]; then PYPI_SITE=`echo ${PYPI_MIRROR} | cut -d '/' -f 3`; echo "[global]\ntrusted-host=$PYPI_SITE\nindex-url=${PYPI_MIRROR}" >  /etc/pip.conf; fi'
RUN set -x \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends git \
        ca-certificates \
        libxml2 \
    && git init /tmp/common/ \
    && git --git-dir /tmp/common/.git fetch --depth 1 $SCRIPTS_REPO $SCRIPTS_REF \
    && git --work-tree /tmp/common --git-dir /tmp/common/.git checkout FETCH_HEAD \
    && /tmp/common/scripts/install.sh
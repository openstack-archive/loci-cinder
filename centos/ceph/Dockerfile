ARG FROM=openstackloci/cinder:centos
FROM ${FROM}

ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && yum install -y ceph-common \
    && yum clean all

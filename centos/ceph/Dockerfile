FROM openstackloci/cinder:centos

ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && yum install -y ceph-common \
    && yum clean all

ARG FROM=openstackloci/cinder:ubuntu
FROM ${FROM}

ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends ceph-common \
    && rm -rf /var/lib/apt/lists/*

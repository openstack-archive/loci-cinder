FROM openstackloci/cinder:debian

ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends lvm2 tgt \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/udev_sync = 1/udev_sync = 0/g' /etc/lvm/lvm.conf \
    && sed -i -e 's/udev_rules = 1/udev_rules = 0/g' /etc/lvm/lvm.conf \
    && sed -i -e 's/use_lvmetad = 0/use_lvmetad =1/g' /etc/lvm/lvm.conf \
    && echo "include /var/lib/cinder/volumes/*" >> /etc/tgt/targets.conf
CMD /usr/sbin/tgtd

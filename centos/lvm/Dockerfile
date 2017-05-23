FROM openstackloci/cinder:centos

ARG OVERRIDE=override

ADD $OVERRIDE /

RUN set -x \
    && yum install -y lvm2 targetcli \
    && sed -i -e 's/udev_sync = 1/udev_sync = 0/g' /etc/lvm/lvm.conf \
    && sed -i -e 's/udev_rules = 1/udev_rules = 0/g' /etc/lvm/lvm.conf \
    && sed -i -e 's/use_lvmetad = 0/use_lvmetad =1/g' /etc/lvm/lvm.conf \
    && systemctl enable lvm2-lvmetad.service \
    && systemctl enable target.service
CMD systemctl start lvm2-lvmetad.service && systemctl start target.service

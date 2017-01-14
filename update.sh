#!/bin/bash
set -x
set -e
set -u

COMMON_INSTALL=$(cat <<'END_HEREDOC'
# common install start
    && if [ -n "$WHEELS" ]; then \\\n\
        curl -sSL ${WHEELS} > /tmp/wheels.tar.gz; \\\n\
       else \\\n\
        TOKEN=$(curl -sSL "https://auth.docker.io/token?service=registry.docker.io&scope=repository:${DOCKER_REPO}:pull" | \\\n\
                    python -c "import sys, json; print json.load(sys.stdin)['token']") \\\n\
        && BLOB=$(curl -sSL -H "Authorization: Bearer ${TOKEN}" https://registry.hub.docker.com/v2/${DOCKER_REPO}/manifests/${DOCKER_TAG} | \\\n\
                    python -c "import sys, json; print json.load(sys.stdin)['fsLayers'][0]['blobSum']") \\\n\
        && curl -sSL -H "Authorization: Bearer ${TOKEN}" https://registry.hub.docker.com/v2/${DOCKER_REPO}/blobs/${BLOB} > /tmp/wheels.tar.gz; \\\n\
       fi \\\n\
    && git clone ${GIT_REPO} /tmp/${PROJECT} \\\n\
    && if [ -n "$GIT_REF" ]; then \\\n\
        git --git-dir /tmp/${PROJECT}/.git fetch ${GIT_REF_REPO} ${GIT_REF} \\\n\
        && git --git-dir /tmp/${PROJECT}/.git checkout FETCH_HEAD; \\\n\
       fi \\\n\
    && mkdir /tmp/packages \\\n\
    && tar xf /tmp/wheels.tar.gz -C /tmp/packages/ --strip-components=2 root/packages \\\n\
    && curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py \\\n\
    && python get-pip.py \\\n\
    && rm get-pip.py \\\n\
    && pip install --no-cache-dir --no-index --no-compile --find-links /tmp/packages --constraint /tmp/packages/upper-constraints.txt /tmp/${PROJECT} \\\n\
    && groupadd -g 42424 ${PROJECT} \\\n\
    && useradd -u 42424 -g ${PROJECT} -M -d /var/lib/${PROJECT} -s /usr/sbin/nologin -c "${PROJECT} user" ${PROJECT} \\\n\
    && mkdir -p /etc/${PROJECT} /var/log/${PROJECT} /var/lib/${PROJECT} /var/cache/${PROJECT} \\\n\
    && chown ${PROJECT}:${PROJECT} /etc/${PROJECT} /var/log/${PROJECT} /var/lib/${PROJECT} /var/cache/${PROJECT} \\\

END_HEREDOC
)

for repo in $(ls dockerfiles/Dockerfile-*); do
    awk -i inplace -v install="${COMMON_INSTALL}" 'BEGIN {p=1} /^# common install start/ {print install; p=0} /^# common install end/ {p=1} p' ${repo}
done

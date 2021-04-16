
FROM mitmproxy/mitmproxy:6.0.2

# set version label
ARG BUILD_DATE
ARG VERSION=1.0.0
ARG MITMPROXY_RELEASE=v0.1.3

LABEL build_version="Mitmproxy version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="t0k4rt"

# add local files
COPY docker_images/mitmproxy/patch/master.py /usr/lib/python3.8/site-packages/mitmproxy/tools/web/master.py
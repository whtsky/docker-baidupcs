FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="whtsky"

ENV TZ=Asia/Shanghai PORT=1999 VER=3.6.7
ENV BAIDUPCS_GO_CONFIG_DIR=/config

RUN \
	echo "**** install packages ****" \
	&& apk add --no-cache curl unzip \
	&& cd /tmp \
	&& curl -fSL https://github.com/liuzhuoling2011/baidupcs-web/releases/download/${VER}/BaiduPCS-Go-${VER}-linux-amd64.zip -o baidupcs.zip \
	&& mkdir -p /defaults \
	&& unzip baidupcs.zip -d /defaults \
	&& mv /defaults/BaiduPCS-Go-${VER}-linux-amd64/BaiduPCS-Go /defaults/BaiduPCS-Go \
	&& rm -rf /defaults/BaiduPCS-Go-${VER}-linux-amd64 \
	&& apk del curl \
	&& rm -rf /tmp

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 1999
VOLUME /root/Downloads
VOLUME /config

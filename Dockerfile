FROM debian:buster-slim
# Baseimage incl. repositories & some software
LABEL org.opencontainers.image.authors Freifunk-MD 
LABEL org.opencontainers.image.source https://github.com/FreifunkMD/wg-docker

RUN apt-get update -y && \
		apt-get install -y --no-install-recommends \
			ca-certificates \
			software-properties-common \
			iptables \
			curl \
			iproute2 \
			ifupdown \
			iputils-ping \
			git \
			apt-transport-https \
			gnupg2 && \
		echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable-wireguard.list && \
		echo "deb http://dl.ffm.freifunk.net/debian-packages/ sid main" > /etc/apt/sources.list.d/ffffm_babel.list && \
		printf 'Package: babeld \nPin: release a=sid\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-babeld_ffffm_sid && \
		printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-unstable && \
		curl https://dl.ffm.freifunk.net/info@wifi-frankfurt.de.gpg.pub | apt-key add - && \
		mkdir -p /etc/wg-broker && \
		apt-get clean && \
		rm -rf /tmp/* /var/cache/apt/* /var/log/*

COPY config/babel_ip_rules /etc/iproute2/rt_tables.d/babel.conf

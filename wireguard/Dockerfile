FROM ffmd/debian:babel-base

RUN apt-get update && \
		apt-get install -y --no-install-recommends wireguard wg-broker && \
		apt-get clean && rm -rf /tmp/* /var/cache/apt/* /var/log/*

EXPOSE 5523/udp
EXPOSE 27275/udp
EXPOSE 6696/udp

COPY scripts /scripts

CMD ["/scripts/run.sh"]

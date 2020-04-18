FROM ffmd/debian:babel-base

RUN apt-get update -y && \
		apt-get install -y --no-install-recommends l3roamd && \
		apt-get clean

EXPOSE 5523

COPY scripts /scripts

CMD ["/scripts/run.sh"]

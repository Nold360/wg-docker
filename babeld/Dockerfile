FROM ffmd/debian:babel-base

RUN apt-get update -y && \
		apt-get install --no-install-recommends -y babeld

COPY scripts /scripts

CMD ["/scripts/run.sh"]

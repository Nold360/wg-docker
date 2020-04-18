FROM ffmd/debian:babel-base

RUN apt-get update && \
		apt-get install -y --no-install-recommends mmfd

COPY scripts /scripts

CMD ["/scripts/run.sh"]

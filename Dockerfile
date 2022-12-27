FROM debian:bullseye


RUN apt-get update && apt-get -y install bash mosquitto-clients wget jq cron itools

COPY salat.sh /
COPY crontab /etc/cron.d/crontab
RUN chmod 0755 /salat.sh && crontab /etc/cron.d/crontab

ENTRYPOINT ["cron", "-f"]

FROM debian:bullseye


RUN apt-get update && apt-get -y install bash mosquitto-clients wget jq cron itools

ADD salat.sh /
ADD crontab /etc/cron.d/crontab
RUN chmod 0755 /salat.sh && chmod 0644/etc/cron.d/crontab && crontab /etc/cron.d/crontab

ENTRYPOINT ["cron", "-f"]

FROM debian:bullseye


RUN apt-get update && apt-get -y install bash mosquitto-clients curl wget jq cron

ADD beem.sh /
ADD entrypoint.sh /
ADD crontab /etc/cron.d/crontab
RUN chmod 0755 /*.sh && chmod 0644 /etc/cron.d/crontab && crontab /etc/cron.d/crontab

ENTRYPOINT ["/entrypoint.sh"]

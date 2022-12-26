FROM debian:bullseye

WORKDIR /app
COPY salat.sh .
RUN chmod 0744 *.sh

COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab &&
    crontab /etc/cron.d/crontab

#Install Cron
RUN apt-get update
RUN apt-get -y install bash mosquitto-clients jq cron itools

ENTRYPOINT ["cron", "-f"]

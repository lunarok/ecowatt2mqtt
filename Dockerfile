FROM debian:bullseye

WORKDIR /usr/scheduler
COPY crontab .
COPY start.sh .
COPY salat.sh .
RUN chmod 0744 salat.sh

#Install Cron
RUN apt-get update
RUN apt-get -y install itools bash mosquitto-clients jq cron

CMD ["./start.sh"]

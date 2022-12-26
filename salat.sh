#!/bin/bash

if [[ -z "${MQTT_HOST}" ]]; then
  mqtt_host="192.168.0.100"
else
  mqtt_host=${MQTT_HOST}
fi

if [[ -z "${MQTT_TOPIC}" ]]; then
  mqtt_topic="salat/time"
else
  mqtt_topic=${MQTT_TOPIC}
fi

if [[ -z "${LATITUDE}" ]]; then
  latitude="47,47"
else
  latitude=${LATITUDE}
fi

if [[ -z "${LONGITUDE}" ]]; then
  longitude="-0,64"
else
  longitude=${LONGITUDE}
fi

array=( (ipraytime --latitude $latitude --longitude $longitude -a 1 --fajrangle 12 --ishaangle 12) )
json='{"imsak":"'`date --date ${array[56]}`'","fajr":"'`date --date ${array[47]}`'","shurooq":"'`date --date ${array[48]}`'","dhuhr":"'`date --date ${array[49]}`'","asr":"'`date --date ${array[50]}`'","maghrib":"'`date --date ${array[51]}`'","isha":"'`date --date ${array[52]}`'","imsak_tomorro":"'`date --date ${array[60]}`'","fajr_tomorrow":"'`date --date ${array[64]}`'"}'

mosquitto_pub -r -h $mqtt_host -t $mqtt_topic -m $json

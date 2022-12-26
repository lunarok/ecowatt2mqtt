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
json='{"imsak":"'array[56]'","fajr":"'array[47]'","shurooq":"'array[48]'","dhuhr":"'array[49]'","asr":"'array[50]'","maghrib":"'array[51]'","isha":"'array[52]'","imsak_tomorro":"'array[60]'","fajr_tomorrow":"'array[64]'"}'
mosquitto_pub -h $MQTT_HOST -t $mqtt_topic -m $json

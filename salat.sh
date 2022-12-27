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
json='{"imsak":"'`date --date ${array[56]}`'","fajr":"'`date --date ${array[47]}`'","shurooq":"'`date --date ${array[48]}`'","dhuhr":"'`date --date ${array[49]}`'","asr":"'`date --date ${array[50]}`'","maghrib":"'`date --date ${array[51]}`'","isha":"'`date --date ${array[52]}`'","imsak_tomorrow":"'`date --date ${array[60]}`'","fajr_tomorrow":"'`date --date ${array[64]}`'"}'

mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak/config -m '{"name": "Imsak", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak}}", "unique_id": "salat.imsak"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr/config -m '{"name": "Fajr", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr}}", "unique_id": "salat.fajr"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/shurooq/config -m '{"name": "Shurooq", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.shurooq}}", "unique_id": "salat.shurooq"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/dhuhr/config -m '{"name": "Dhuhr", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.dhuhr}}", "unique_id": "salat.dhuhr"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/asr/config -m '{"name": "Asr", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.asr}}", "unique_id": "salat.asr"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/maghrib/config -m '{"name": "Maghrib", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.maghrib}}", "unique_id": "salat.maghrib"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/isha/config -m '{"name": "Isha", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.isha}}", "unique_id": "salat.isha"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak_tomorrow/config -m '{"name": "Imsak Tomorrow", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak_tomorrow}}", "unique_id": "salat.imsak_tomorrow"}
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr_tomorrow/config -m '{"name": "Fajr Tomorrow", "device_class": "date", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr_tomorrow}}", "unique_id": "salat.fajr_tomorrow"}


mosquitto_pub -r -h $mqtt_host -t $mqtt_topic -m $json

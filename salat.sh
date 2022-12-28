#!/bin/bash

mqtt_host="${MQTT_HOST:-192.168.0.100}"
mqtt_topic="${MQTT_TOPIC:-salat/time}"
latitude="${LATITUDE:-47,47}"
longitude="${LONGITUDE:--0,64}"

echo "Using : "${mqtt_host}" "${mqtt_topic}" "${latitude}" "${longitude}

array=( $(ipraytime --latitude ${latitude} --longitude ${longitude} -a 1 --fajrangle 12 --ishaangle 12) )
json='{"imsak":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[56]}`'","fajr":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[47]}`'","shurooq":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[48]}`'","dhuhr":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[49]}`'","asr":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[50]}`'","maghrib":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[51]}`'","isha":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[52]}`'","imsak_tomorrow":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[60]}`'","fajr_tomorrow":"'`date -u +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[64]}`'"}'

mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak/config -m '{"name": "Imsak", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak}}", "unique_id": "salat.imsak"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr/config -m '{"name": "Fajr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr}}", "unique_id": "salat.fajr"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/shurooq/config -m '{"name": "Shurooq", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.shurooq}}", "unique_id": "salat.shurooq"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/dhuhr/config -m '{"name": "Dhuhr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.dhuhr}}", "unique_id": "salat.dhuhr"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/asr/config -m '{"name": "Asr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.asr}}", "unique_id": "salat.asr"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/maghrib/config -m '{"name": "Maghrib", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.maghrib}}", "unique_id": "salat.maghrib"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/isha/config -m '{"name": "Isha", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.isha}}", "unique_id": "salat.isha"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak_tomorrow/config -m '{"name": "Imsak Tomorrow", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak_tomorrow}}", "unique_id": "salat.imsak_tomorrow"}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr_tomorrow/config -m '{"name": "Fajr Tomorrow", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr_tomorrow}}", "unique_id": "salat.fajr_tomorrow"}'

echo $json

mosquitto_pub -r -h $mqtt_host -t $mqtt_topic -m "${json}"

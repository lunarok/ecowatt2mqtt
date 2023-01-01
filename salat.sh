#!/bin/bash

mqtt_host="${MQTT_HOST:-192.168.0.100}"
mqtt_topic="${MQTT_TOPIC:-salat/time}"
latitude="${LATITUDE:-47,47}"
longitude="${LONGITUDE:--0,64}"

echo "Using : "${mqtt_host}" "${mqtt_topic}" "${latitude}" "${longitude}

array=( $(ipraytime --latitude ${latitude} --longitude ${longitude} -a 1 --fajrangle 12 --ishaangle 12) )
json='{"imsak":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[56]}`'","fajr":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[47]}`'","shurooq":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[48]}`'","dhuhr":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[49]}`'","asr":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[50]}`'","maghrib":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[51]}`'","isha":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[52]}`'","imsak_tomorrow":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[60]}`'","fajr_tomorrow":"'`date +"%Y-%m-%dT%H:%M:%S%:z" --date ${array[64]}`'"}'

mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak/config -m '{"name": "Imsak", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak}}", "unique_id": "salat.imsak", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr/config -m '{"name": "Fajr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr}}", "unique_id": "salat.fajr", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/shurooq/config -m '{"name": "Shurooq", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.shurooq}}", "unique_id": "salat.shurooq", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/dhuhr/config -m '{"name": "Dhuhr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.dhuhr}}", "unique_id": "salat.dhuhr", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/asr/config -m '{"name": "Asr", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.asr}}", "unique_id": "salat.asr", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/maghrib/config -m '{"name": "Maghrib", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.maghrib}}", "unique_id": "salat.maghrib", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/isha/config -m '{"name": "Isha", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.isha}}", "unique_id": "salat.isha", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/imsak_tomorrow/config -m '{"name": "Imsak Tomorrow", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.imsak_tomorrow}}", "unique_id": "salat.imsak_tomorrow", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/salat/fajr_tomorrow/config -m '{"name": "Fajr Tomorrow", "device_class": "timestamp", "state_topic": "'${mqtt_topic}'", "value_template": "{{ value_json.fajr_tomorrow}}", "unique_id": "salat.fajr_tomorrow", "device": {"model": "salat", "identifiers": ["mqtt-salat-'${latitude}'-'${longitude}'"], "name": "Salat", "manufacturer": "Salat"}}'

echo $json

mosquitto_pub -r -h $mqtt_host -t $mqtt_topic -m "${json}"

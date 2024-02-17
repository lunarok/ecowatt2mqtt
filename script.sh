#!/bin/bash
mqtt_host="${MQTT_HOST:-192.168.0.100}"
mqtt_topic="${MQTT_TOPIC:-angers/status}"

auth='Authorization: Basic '"${PASSWORD}"

token=`curl -H "Authorization: Basic $PASSWORD" -H "Content-Type: application/x-www-form-urlencoded" -X POST https://digital.iservices.rte-france.com/token/oauth/ | jq .access_token | tr -d '"'`
result=`curl -H "Authorization: Bearer $token" https://digital.iservices.rte-france.com/open_api/ecowatt/v4/signals`

echo $result

mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/ecowatt/now/config -m '{"name": "Etat réseau actuel", "state_topic": "ecowatt/status", "value_template": "{{ value_json.now}}", "unique_id": "mqtt.ecowatt.now", "device": {"model": "Ecowatt", "identifiers": ["mqtt-ecowatt"], "name": "Ecowatt", "manufacturer": "Ecowatt"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/ecowatt/nexthour/config -m '{"name": "Etat réseau prochaine heure", "state_topic": "ecowatt/status", "value_template": "{{ value_json.nexthour}}", "unique_id": "mqtt.ecowatt.nexthour", "device": {"model": "Ecowatt", "identifiers": ["mqtt-ecowatt"], "name": "Ecowatt", "manufacturer": "Ecowatt"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/ecowatt/today/config -m '{"name": "Etat réseau aujourd'hui", "state_topic": "ecowatt/status", "value_template": "{{ value_json.0.dvalue}}", "unique_id": "mqtt.ecowatt.today", "device": {"model": "Ecowatt", "identifiers": ["mqtt-ecowatt"], "name": "Ecowatt", "manufacturer": "Ecowatt"}}'
mosquitto_pub -r -h $mqtt_host -t homeassistant/sensor/ecowatt/tomorrow/config -m '{"name": "Etat réseau demain", "state_topic": "ecowatt/status", "value_template": "{{ value_json.1.dvalue}}", "unique_id": "mqtt.ecowatt.tomorrow", "device": {"model": "Ecowatt", "identifiers": ["mqtt-ecowatt"], "name": "Ecowatt", "manufacturer": "Ecowatt"}}'

mosquitto_pub -r -h $mqtt_host -t $mqtt_topic -m '$result'

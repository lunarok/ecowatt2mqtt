#!/bin/bash

printenv | grep -v "no_proxy" >> /etc/environment
env | cat - /script.sh > temp && mv temp /script.sh

cron -f

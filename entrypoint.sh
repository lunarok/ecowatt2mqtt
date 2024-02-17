#!/bin/bash

printenv | grep -v "no_proxy" >> /etc/environment
env | cat - /angers.sh > temp && mv temp /angers.sh

cron -f

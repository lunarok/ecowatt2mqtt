#!/bin/bash

printenv | grep -v "no_proxy" >> /etc/environment
env | cat - /beem.sh > temp && mv temp /beem.sh

cron -f

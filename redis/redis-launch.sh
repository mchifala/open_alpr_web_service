#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
# and and service
#

#gcloud container clusters get-credentials lab8

docker pull redis
kubectl create deployment lab8-redis --image=redis
kubectl expose deployment lab8-redis--port 6379

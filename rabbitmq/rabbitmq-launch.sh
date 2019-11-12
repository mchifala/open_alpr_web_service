#!/bin/sh
#
# This is the script you need to provide to launch a rabbitmq instance
# service

#gcloud container clusters get-credentials lab8

docker pull rabbitmq
kubectl create deployment lab8-rabbitmq --image=rabbitmq
kubectl expose deployment lab8-rabbitmq--port 5672

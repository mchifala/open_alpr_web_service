#!/bin/sh

#gcloud container clusters get-credentials lab8

docker pull rabbitmq
kubectl create deployment rabbitmq --image=rabbitmq
kubectl expose deployment rabbitmq --port 5672

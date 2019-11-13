#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
# and cause it to run the redis-install.sh script
docker build -t worker:0.1 .
docker tag worker:0.1 gcr.io/csci5253/worker:0.1
docker push gcr.io/csci5253/worker:0.1
kubectl create deployment worker --image=gcr.io/csci5253/worker:0.1
kubectl scale deployment worker --replicas=3

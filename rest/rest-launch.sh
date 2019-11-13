#!/bin/sh

#gcloud container clusters get-credentials lab8

docker build -t rest:0.1 .
docker tag rest:0.1 gcr.io/csci5253/rest:0.1
gcloud auth configure-docker
docker push gcr.io/csci5253/rest:0.1
kubectl create deployment rest --image=gcr.io/csci5253/rest:0.1
kubectl expose deployment rest --type=LoadBalancer --port 5000

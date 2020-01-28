#!/bin/sh

# The following command must be run to get the Google Kubernetes Engine
# credentials for a particular cluster. It must be run prior to executing any of
# the launch shell scripts. 
# gcloud container clusters get-credentials [cluster_name]

# This script pulls the latest Redis image from the Docker Hub and deploys
# the container in a pod with the name 'redis' in the Kubernetes cluster.
# It also exposes port 6379 for the redis service (the default Redis port)

docker pull redis
kubectl create deployment redis --image=redis
kubectl expose deployment redis --port 6379

#!/bin/sh

# This script pulls the latest Redis image from the Docker Hub and deploys
# the container in a pod with the name 'redis' in the Kubernetes cluster.
# It also exposes port 6379 for the redis service (the default Redis port)

docker pull redis
kubectl create deployment redis --image=redis
kubectl expose deployment redis --port 6379

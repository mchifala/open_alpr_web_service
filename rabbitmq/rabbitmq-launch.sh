#!/bin/sh

# The following command must be run to get the Google Kubernetes Engine
# credentials for a particular cluster. It must be run prior to executing any of
# the launch shell scripts. 
# gcloud container clusters get-credentials [cluster_name]

# This script pulls the latest RabbitMQ image from the Docker Hub and deploys
# the container in a pod with the name 'rabbitmq' in the Kubernetes cluster.
# It also exposes port 5672 for the redis service (the default RabbitMQ port)

docker pull rabbitmq
kubectl create deployment rabbitmq --image=rabbitmq
kubectl expose deployment rabbitmq --port 5672

#!/bin/sh

# This script pulls the latest RabbitMQ image from the Docker Hub and deploys
# the container in a pod with the name 'rabbitmq' in the Kubernetes cluster.
# It also exposes port 5672 for the rabbitmq service (the default RabbitMQ port)

docker pull rabbitmq
kubectl create deployment rabbitmq --image=rabbitmq
kubectl expose deployment rabbitmq --port 5672

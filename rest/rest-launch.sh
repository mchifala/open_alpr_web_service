#!/bin/sh

# The following command must be run to get the Google Kubernetes Engine
# credentials for a particular cluster. It must be run prior to executing any of
# the launch shell scripts.
# gcloud container clusters get-credentials [cluster_name]

# This script builds the Dockerfile into a Docker image, tags it as
# rest:[version] and pushes it to the Docker registry. It then deploys
# the container in a pod with the name 'rest' in the Kubernetes cluster.
# It also exposes port 5000 for the rest service (the default Flask port)

docker build -t rest:0.1 .
docker tag rest:0.1 gcr.io/csci5253/rest:0.1
gcloud auth configure-docker
docker push gcr.io/csci5253/rest:0.1
kubectl create deployment rest --image=gcr.io/csci5253/rest:0.1
kubectl expose deployment rest --type=LoadBalancer --port 5000

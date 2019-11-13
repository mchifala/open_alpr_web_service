# Michael W. Chifala
**CSCI 5253**

**Date:** 11/13/2019

**Collaboration:**  Brian Groenke

# Lab 8 Solution:

### Kubernetes Cluster:
I used a cluster of 3 n1-standard-1 machines for my lab8 Kubernetes cluster.

## Methodology:

### RabbitMQ:
1. Pulled most recent RabbitMQ image from Dockerhub.
2. Created a Kubernetes pod using the RabbitMQ image
3. Exposed port 5672 (the default RabbitMQ port) with internal IP address to other pods in the cluster

```
bash rabbitmq-launch.sh
```

### Redis:
1. Pulled most recent Redis image from Dockerhub.
2. Created a Kubernetes pod using the Redis image
3. Exposed port 6379 (the default Redis port) with internal IP address to other pods in the cluster

```
bash redis-launch.sh
```

### Rest Server:
1. Built image from Dockerfile which contained the same code as lab 7's launch script for the rest server.
2. Tagged the Docker image and pushed to the Google container registry
3. Created a Kubernetes pod using this image
4. Exposed port 5000 (the default Flask port) with type LoadBalancer to create an external IP address

```
bash rest-launch.sh
```

### Worker Node:
1. Built image from Dockerfile which contained the same code as lab 7's launch script for the worker node.
2. Tagged the Docker image and pushed to the Google container registry
3. Created a Kubernetes pod using this image and replicated two additional times
Note: No service needed to be created for the worker nodes.

```
bash worker-launch.sh
```

# RabbitMQ Messaging

## Overview
The `rabbitmq-launch.sh` script creates and deploys a container that provides a RabbitMQ message server. RabbitMQ contains two message queues:  the `toWorker` work queue and `logs`.

## Getting started

These instructions will get you a RabbitMQ message server up and running on your Google Kubernetes Engine cluster.

### Prerequisites

The following packages/tools are necessary to successfully execute the `rabbitmq-launch.sh` script

- docker
- kubectl
- gcloud

**Installing packages and configuring master VM:**
For convenience, a `vm_setup.sh` script is provided in the main directory of this project. This script can be used to install docker, gcloud, and kubectl command line tools onto a Google Compute Engine virtual machine (VM). This master VM can then be used to easily communicate with the Google Kubernetes Engine cluster.

First, create a new VM (Ubuntu 18.04 preferred) in Google Compute Engine. SSH into the VM, clone the Github repository, and execute the following command.

```
bash vm_setup.sh
```

**Google Kubernetes Engine credentials:**
The following command must be run to get the Google Kubernetes Engine credentials for a particular cluster. It must be run prior to executing any of the launch shell scripts.

```
gcloud container clusters get-credentials [cluster_name]
```

###Launching RabbitMQ service

Once credentials have been obtained, execute the following command from the cloned Github repository on the master VM.

```
bash rabbitmq-launch.sh
```

### Notes
The container and resulting service name are named `rabbitmq` so that worker nodes can use DNS names to locate the instance.

You do not need to create any queues or exchanges; this will be done by the worker and rest containers.

If you restart, delete, or redeploy your RabbitMQ container, any messages (i.e. outstanding images that need to be processed) will not be retained. There are extensive directions on how to turn this into a reliable service (https://www.rabbitmq.com/admin-guide.html).

## Authors

**Michael W. Chifala** - University of Colorado, Boulder, CSCI 5253: Data Center Scale Computing

## Acknowledgments

* Dirk Grunwald, University of Colorado, Boulder
* RabbitMQ Docker image: https://hub.docker.com/_/rabbitmq
* Github: PurpleBooth/README-Template.md
* RabbitMQ: https://www.rabbitmq.com/documentation.html

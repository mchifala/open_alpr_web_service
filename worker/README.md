# ALPR workers

## Overview
The `worker-launch.sh` script creates and deploys a user-specified number of containers that process the images using the ALPR software. Each worker will listen to the `toWorkers` RabbitMQ exchange, receive queued messages, execute OpenALPR to extract license plate and geolocation data, store processed data in Redis databases, and send an acknowledgement of successful processing to RabbitMQ.

## Getting started

These instructions will get you ALPR workers up and running on your Google Kubernetes Engine cluster.

### Prerequisites

The following packages/tools are necessary to successfully execute the worker-launch.sh script

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

### Launching ALPR workers

Once credentials have been obtained, execute the following command from the cloned Github repository on the master VM. The script will deploy three replica containers by default, however, `worker-launch.sh` may be modified to specify another number of replicas.

```
bash worker-launch.sh
```


### Notes

None

## Authors

**Michael W. Chifala** - University of Colorado, Boulder, CSCI 5253: Data Center Scale Computing

## Acknowledgments

* Dirk Grunwald, University of Colorado, Boulder
* Github: PurpleBooth/README-Template.md
* OpenALPR: https://github.com/openalpr/openalpr

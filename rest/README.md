# REST API

## Overview
The `rest-launch.sh` script creates and deploys a container that provides a Flask REST API. The REST API has three endpoints and is the only client facing component of the web service.

## Getting started

These instructions will get you a Flask REST API up and running on your Google Kubernetes Engine cluster.

### Prerequisites

The following packages/tools are necessary to successfully execute the `rest-launch.sh` script

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

### Launching Flask REST API:

Once credentials have been obtained, execute the following command from the cloned Github repository on the master VM.

```
bash rest-launch.sh
```

### API Endpoints

+ `http://<ip>/image/[filename] [PUT]` -- Upload an image with a specified file name. The rest container will compute the MD5 of the image's content and send the MD5 and image to a worker container using the `toWorker` RabbitMQ exchange. The filename is added to the Redis database. Return the MD5 hash used to identify the provided image.

Ex. Response JSON

```
  { "hash" : "abcedef...128" }
```

+ `http://<ip>/hash/[checksum] [GET]` -- Using the MD5 hash, return a list of the license plates and geotagged information associated with the picture that results in this hash. If the image had no geotags or license plates, an empty list is returned.

Ex. Response JSON

```
  { "plates" : [{"plate1: ABC789", "confidence": 0.99}, {"plate2: XYZ123", "confidence": 0.99}], "latitude": "40.0150° N", 'longitude': 105.2705° W }
```

+ `http://<ip>/license/[licence] [GET]` -- Using the provided license string, return a list of the MD5 hashes for images that contain this license plate. If the license plate doesn't exist in any processed image, an empty list is returned.

Ex. Response JSON

```
  {"hashes": [hash1, hash2, ..., hashn]}
```

### Notes
The container and resulting service name are named `rest` so that worker nodes can use DNS names to locate the instance.

This container is the only container in the Kubernetes cluster that will have an external endpoint.


## Authors

**Michael W. Chifala** - University of Colorado, Boulder, CSCI 5253: Data Center Scale Computing

## Acknowledgments

* Dirk Grunwald, University of Colorado, Boulder
* Github: PurpleBooth/README-Template.md
* Flask: http://flask.palletsprojects.com/en/1.1.x/

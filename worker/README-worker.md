# ALPR workers

The worker-launch.sh script creates and deploys a user-specified number of containers that process the images using the ALPR software.

## Getting started

These instructions will get you ALPR workers up and running on your Google Kubernetes Engine cluster.

### Prerequisites

The following packages/tools are necessary to successfully execute the worker-launch.sh script

- docker
- kubectl
- gcloud

**Installing packages and configuring master VM:**
For convenience, a vm_setup.sh script is provided in the main directory of this project. This script can be used to install docker, gcloud, and kubectl command line tools onto a Google Compute Engine virtual machine (VM). This master VM can then be used to easily communicate with the Google Kubernetes Engine cluster.

First, create a new VM (Ubuntu 18.04 preferred) in Google Compute Engine. SSH into the VM, clone the Github repository, and execute the following command.

```
bash vm_setup.sh
```

**Google Kubernetes Engine credentials:**
The following command must be run to get the Google Kubernetes Engine credentials for a particular cluster. It must be run prior to executing any of the launch shell scripts.

```
gcloud container clusters get-credentials [cluster_name]
```

### Execution

**Launching ALPR workers:**

Once credentials have been obtained, execute the following command from the cloned Github repository on the master VM.

```
bash worker-launch.sh
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



# ALPR Worker

The steps you need to take:
+ Create a worker image that can execute OpenALPR, run RabbitMQ clients and has access to a remote Redis database
+ Develop a Python program that listens to the `toWorkers` RabbitMQ exchange, receives a message, check for geotags and if found, scans for a license plate.
+ Create a shell script or python program that will automatically launch another worker.

## Creating a worker image
You should first create a "worker image" and then use that to create multiple worker instances.

You can either use a Python program to create the worker image, or a series of `gcloud` commands. In particular, you may want to use [`gcloud compute instances create](https://cloud.google.com/sdk/gcloud/reference/compute/instances/create) with the `--metadata-from-file` option to specify the startup script that will install software.

You'll be provided with a `build-worker-src.sh` script that installs the OpenALPR software from source. Although Ubuntu 18.04 has an OpenALPR package, it doesn't work. You can use the packaged version if you use Ubuntu 19.10 and script `build-worker-u19.10.sh` which installs the appropriate package and fixes an error in the provided installation.

You can install your Python program by providing it via the `--metadata-from-file` option and copying it to a location you specify or whatever method you prefer. Your final image file should have all software needed installed to reduce the time needed to launch a new worker.

Once you have your worker configured, [create an image using the gcloud command line or a program](https://cloud.google.com/sdk/gcloud/reference/compute/images/create). You'll use that to spin up other workers.


Upon receiving the message, you should first determine if the image contains geotagged information. The sample program `provided-GetLatLon.py` shows you how to extract the latitude and longitude from a photo. See the description of the images to test your code.  Other image formats, such as `png` don't support the extended headers we're looking for; however, your solution should be robust to being handed bad image files.

If the image is geotagged, you should then look for a license plate. You can use the [python API for this](https://pypi.org/project/openalpr/) or use the command line. The file `provided-getAlpr.py` shows an example of using the python API to scan an image and pull the most likely plate.

Following this, if the image is both geotagged and has a license plate, you will update the Redis database with the results. Redis is a Key-Value store that has simple Get/Put methods and also has an internal "list" datatype. You can read more about [the Python interface](https://pypi.org/project/redis/). Redis supports a number of datatypes including lists and sets. In many cases, the set data type will be the most appropriate because we only want a single instance of a data item associated with a key.


Once the database has been updated or when you determine there is no geotagged information and/or you can't get a license plate, you should then `acknowledge` the RabbitMQ message. You should only acknowledge it after you've processed it.

At each step of your processing, you may want to log debug information using the `topic` queue and `[hostname].worker.debug`. When you've added the data to the database, you *must* log that as `[hostname].worker.info`, substituting the proper worker name.

When installing the `pika` library used to communicate with `rabbitmq`, you should use the `pip` or `pip3` command to install the packages. E.g.
```
sudo pip3 install --upgrade pika
```

## Create shell script to launch workers

You should create a shell script `worker-addworker.sh` (using the `gcloud` commands) or a python program to launch a new worker. That script must also start the worker script in the image. Make sure that your instance does not have an external IP address using the `--network-interface=no-address` flag if using the `gcloud` command interface or similar method if using Python.

Y

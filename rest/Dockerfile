FROM ubuntu:bionic-20191029

RUN apt-get update && \
    apt-get install -y python3-pip git && \
    apt install -y python3-flask && \
    pip3 install pika && \
    pip3 install jsonpickle && \
    pip3 install redis && \
    mkdir lab7

WORKDIR /lab7

EXPOSE 5000

ADD logs.py logs.py

ADD rest-server.py rest-server.py

CDM [/bin/bash]

FROM ubuntu:eoan-20191017

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y openalpr && \
    (cd /usr/share/openalpr/runtime_data/ocr/; cp tessdata/lus.traineddata .) && \
    apt-get install -y python3 python3-pip python3-pillow python3-openalpr python3-redis && \
    sudo pip3 install pika && \
    sudo pip3 install jsonpickle && \
    mkdir lab7

WORKDIR /lab7

ADD worker-server.py worker-server.py

RUN chmod 777 worker-server.py

CMD python3 worker-server.py

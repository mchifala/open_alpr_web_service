FROM ubuntu:bionic-20191029
RUN apt-get update && \
    apt-get install -y python3 python3-pip git && \
    apt install -y python3-flask && \
    pip3 install pika && \
    pip3 install jsonpickle && \
    pip3 install redis && \
    mkdir lab7
WORKDIR /lab7
EXPOSE 5000
ADD logs-consumer.py logs-consumer.py
ADD rest-server.py rest-server.py
RUN chmod 777 rest-server.py && chmod 777 logs-consumer.py
CMD python3 rest-server.py

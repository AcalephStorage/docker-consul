FROM ubuntu:trusty

ENV CONSUL_VERSION 0.5.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y unzip curl

ADD https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip

RUN unzip /tmp/consul.zip && \
    chmod +x consul && \
    mv consul /usr/bin/consul && \
    rm /tmp/consul.zip

RUN mkdir -p /etc/consul.d && \
    chmod a+w /etc/consul.d

RUN mkdir -p /var/lib/consul && \
    chmod a+w /var/lib/consul

ADD ./configs/default.json /etc/consul.d/default.json

VOLUME ["/etc/consul.d", "/var/lib/consul"]

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

ADD ./run /usr/local/bin/run

CMD ["/usr/local/bin/run"]

FROM ubuntu:trusty

ENV CONSUL_VERSION 0.5.2

RUN apt-get update && \
    apt-get install -y unzip wget && \
    wget https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip && \
    unzip ${CONSUL_VERSION}_linux_amd64.zip && \
    chmod +x consul && \
    mv consul /usr/bin/consul && \
    rm ${CONSUL_VERSION}_linux_amd64.zip && \
    mkdir -p /etc/consul.d && \
    chmod a+w /etc/consul.d && \
    mkdir -p /var/lib/consul && \
    chmod a+w /var/lib/consul

ADD ./configs/default.json /etc/consul.d/default.json
ADD ./run /usr/local/bin/run

# if not overriden, will use $(hostname -s) during startup
ENV NODE_NAME localhost

ENV JOIN_CLUSTER FALSE
ENV JOIN_ADDR 1.1.1.1

ENV SERVER FALSE
ENV BOOTSTRAP_EXPECT 1

ENV BIND_ADDR 0.0.0.0
ENV CLIENT_ADDR 0.0.0.0

VOLUME ["/etc/consul.d", "/var/lib/consul"]
EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

CMD ["/usr/local/bin/run"]

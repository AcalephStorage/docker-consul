#!/usr/bin/env bash
echo 'Installing docker...'
curl -sSL https://get.docker.com/ | sh

echo 'Loading Docker images to VMs...'
sudo docker load -i /vagrant/consul.tar

echo 'Preparing docker environment'
mkdir -p /home/vagrant/{datadir,confdir}

JOIN_ARGS=''

echo 'Running Consul Containers...'
sudo docker run -d --name consul --net host \
  -p 8300:8300 \
  -p 8301:8301 \
  -p 8301:8301/udp \
  -p 8302:8302 \
  -p 8302:8302/udp \
  -p 8400:8400 \
  -p 8500:8500 \
  -p 8600:8600 \
  -p 8600:8600/udp \
  -e NODE_NAME=$1 \
  -e BOOTSTRAP_EXPECT=3 \
  -e SERVER=TRUE \
  -e BIND_ADDR=$2 \
  $3 \
  -v /home/vagrant/datadir:/var/lib/consul -v /home/vagrant/confdir:/etc/consul.d local/consul:latest

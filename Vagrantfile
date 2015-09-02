# -*- mode: ruby -*-
# vi: set ft=ruby :

if ARGV[0] == 'up' || ARGV[0] == 'reload'
  puts "Creating docker build..."
  system 'docker build -t local/consul .'
  puts "Saving docker image as consul.tar..."
  system 'docker save -o consul.tar local/consul:latest'
end

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  3.times do |i|
    config.vm.define "consul-#{i}" do |consul|
      consul.vm.hostname = "consul-#{i}"
      consul.vm.network :private_network, ip: "10.5.5.#{10+i}"

      args = [
        "consul-#{i}",
        "10.5.5.#{10+i}"
      ]
      args << '-e JOIN_CLUSTER=TRUE -e JOIN_ADDR=10.5.5.10' unless i.zero?

      consul.vm.provision :shell, 
        path: 'provision.sh',
        args: args
    end
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'delorub-dev'

  config.vm.network :forwarded_port, guest: 5000, host: 5000
  config.vm.network :forwarded_port, guest: 9002, host: 9002

  config.vm.network :private_network, ip: '10.10.10.61'

  config.vm.provision :bootstrap, type: :shell, path: 'vagrant/bootstrap.sh', keep_color: true
  config.vm.provision :project, type: :shell, path: 'vagrant/project.sh', keep_color: true

  config.vm.provider 'virtualbox' do |v|
    v.memory = 4096
    v.cpus = 2
  end
end

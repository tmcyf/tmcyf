# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-16.04"
  config.omnibus.chef_version = "12.14.60"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder '.', '/vagrant', nfs: true

  config.vm.provider "virtualbox" do |vb|

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "platform_packages"
    chef.add_recipe "vim"
    chef.add_recipe "nodejs"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"
    chef.add_recipe "postgresql::setup_users"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.4.1"],
          global: "2.4.1",
          gems: {
            "2.4.1" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      "postgresql": {
        "users": [
          {
            "username": "vagrant",
            "password": "databasepassword",
            "superuser": true,
            "createdb": true,
            "createrole": false
          }
        ],
        "databases": [
          {
            "name": "vagrant",
            "owner": "vagrant"
          }
        ]
      },
      "platform_packages" => {
        "pkgs" => [
          { "name" => "libqt4-dev",
            "action" => "install"
          },
          { "name" => "libpq-dev",
            "action" => "install"
          }
        ]
      }
    }
  end
end

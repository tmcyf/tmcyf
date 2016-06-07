# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.berkshelf.enabled = true

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end


  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "platform_packages"
    chef.add_recipe "nodejs"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "vim"

    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.4"],
          global: "2.2.4",
          gems: {
            "2.2.4" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      "postgresql" => {
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

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vagrant.plugins = "vagrant-hostmanager"

    # BOX SETTINGS
    config.vm.box = "sternpunkt/jimmybox"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.customize ["modifyvm", :id, "--audio", "none"]
        v.name = "Keystone Immosearch"
    end

    # NETWORKING
    ############################################################################

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.aliases = "www.keystone-immosearch.test"

    config.vm.hostname = "keystone-immosearch.test"

    # Private Network
    config.vm.network "private_network", ip: "192.168.33.11"

    # port forwarding must be enabled for vagrant share
    config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

    # Public network:
    # uncomment the lines and add your own config (bridge, ip, etc.)

    # config.vm.network "public_network",
    # :bridge => "en0: WLAN (Airport)",
    # ip: "192.168.10.201", :netmask => "255.255.255.0", auto_config: true

    # SYNCED FOLDERS
    ############################################################################

    # DEFAULT:
    config.vm.synced_folder "./public", "/var/www", :mount_options => ["dmode=777", "fmode=777"]

    # NFS:
    # you should try NFS share - it performs much better than the default synced folder!
    # config.vm.synced_folder "./public", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=777"] }

    # NFS in MacOS 10.15 Catalina and higher:
    # due to a bug in Catalina you should use an absolute path to your directory:
    # config.vm.synced_folder "/Volumes/Macintosh HD/Users/your-user/Vagrant/jimmybox/public", "/var/www", type: 'nfs', mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=1']

    # RSYNC:
    # if you are using a framework that contains many files rsync can provide best performance
    # You can use vagrant rsync-auto to sync changes automatically to your vagrant box.
    # config.vm.synced_folder "./public", "/var/www", type: "rsync", rsync__auto: true

    # PROVISIONERS
    ############################################################################

    # prepare the host
    config.vm.provision "shell", inline: "sudo rm -rf /usr/local/vagrant && sudo mkdir /usr/local/vagrant/ && sudo chmod -R 777 /usr/local/vagrant"

    # Virtual Hosts
    config.vm.provision "file", source: "./provisioning/hosts", destination: "/usr/local/vagrant/"

    # SSL Certificates
    config.vm.provision "file", source: "./provisioning/ssl", destination: "/usr/local/vagrant/"

    # php.ini configs
    config.vm.provision "file", source: "./provisioning/php.ini", destination: "/usr/local/vagrant/"

    # Execute Updates
    # config.vm.provision "shell", path: "./provisioning/setup/updates.sh"

    # Execute the apache setup scripts
    config.vm.provision "shell", path: "./provisioning/setup/apache.sh"

    # php.ini files
    config.vm.provision "shell", path: "./provisioning/setup/php.sh"

    # Setup MailHog
    # config.vm.provision "shell", path: "./provisioning/setup/mailhog.sh"

    # Install wp-cli
    config.vm.provision "shell", privileged: false, path: "./provisioning/setup/wp-cli.sh"

    # Create default database if not exists
    config.vm.provision "shell", inline: <<-SHELL

      mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS dbname CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci"

    SHELL

end

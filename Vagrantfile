# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "puppetmaster" do |puppetmaster|
   puppetmaster.vm.box = "trusty64/kr"
   #puppetmaster.vm.box_url = "file:///c:/cygwin64/home/A/puppet/trusty.box"
   puppetmaster.vm.provision "shell", :path => "package_and_time.sh"
   puppetmaster.vm.provision "shell", :path => "install-puppet-master.sh"
   puppetmaster.vm.network "private_network",ip:"10.100.0.2"
        #virtualbox__nat: false
   puppetmaster.vm.host_name = "puppetmaster"
      puppetmaster.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id,"--memory","1024"]
        vb.customize ["modifyvm", :id, "--usbehci", "off"]
        vb.customize ["modifyvm", :id, "--usb", "off"]
      end
   end


  config.vm.define "puppetclient1" do |puppetclient1|
   puppetclient1.vm.box = "trusty64/kr"
   puppetclient1.vm.provision "shell", :path => "package_and_time.sh"
   puppetclient1.vm.provision "shell", :path => "install-puppet-node.sh"
   puppetclient1.vm.network "private_network",ip:"10.100.0.3"
   puppetclient1.vm.host_name = "puppetclient1"
      puppetclient1.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id,"--memory","512"]
        vb.customize ["modifyvm", :id, "--usbehci", "off"]
        vb.customize ["modifyvm", :id, "--usb", "off"]
      end
   end


  config.vm.define "puppetclient2" do |puppetclient2|
   puppetclient2.vm.box = "trusty64/kr"
   puppetclient2.vm.provision "shell", :path => "package_and_time.sh"
   puppetclient2.vm.provision "shell", :path => "install-puppet-node.sh"
   puppetclient2.vm.network "private_network",ip:"10.100.0.4"
   puppetclient2.vm.host_name = "puppetclient2"
      puppetclient2.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id,"--memory","512"]
        vb.customize ["modifyvm", :id, "--usbehci", "off"]
        vb.customize ["modifyvm", :id, "--usb", "off"]
      end
   end






  config.vm.define "ct7-pclient" do |ct7|
   ct7.vm.box = "oyj/centos7"
   ct7.vm.provision "shell", :path => "install-puppet-node.sh"
   ct7.vm.provision "shell", :path => "package_and_time.sh"
   ct7.vm.provision "shell", inline: "sudo nmcli connection reload; sudo systemctl restart network.service"
   ct7.vm.network "private_network", ip:"10.100.0.5"
   ct7.vm.synced_folder ".", "/vagrant", type: "virtualbox"
   ct7.vm.host_name = "ct7-pclient"
     ct7.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
      vb.customize ["modifyvm", :id, "--usb", "off"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
     end
  end



  config.vm.define "control-pmaster" do |ct7|
   ct7.vm.box = "oyj/centos7"
   ct7.vm.provision "shell", :path => "install-puppet-node.sh"
   ct7.vm.provision "shell", :path => "package_and_time.sh"
   ct7.vm.network "private_network", ip:"10.100.0.7"
   ct7.vm.provision "shell", inline: "sudo nmcli connection reload; sudo systemctl restart network.service"
   ct7.vm.host_name = "control-pmaster"
     ct7.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
      vb.customize ["modifyvm", :id, "--usb", "off"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
     end
   ct7.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  end


   
  config.vm.define "test-pnode" do |ct7|
   ct7.vm.box = "oyj/centos7"
   ct7.vm.provision "shell", :path => "install-puppet-node.sh"
   ct7.vm.provision "shell", :path => "package_and_time.sh"
   ct7.vm.provision "shell", inline: "sudo nmcli connection reload; sudo systemctl restart network.service"
   ct7.vm.network "private_network", ip:"10.100.0.9"
   ct7.vm.host_name = "test-pnode"
     ct7.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "256"]
      vb.customize ["modifyvm", :id, "--usb", "off"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
     end
  end


  config.vm.define "testnode" do |testnode|
   testnode.vm.box = "oyj/centos7"
   #testnode.vm.box_url = "file://C:/cygwin64/home/A/puppet/centos7.box"
   testnode.vm.provision "shell", :path => "install-puppet-node.sh"
   testnode.vm.provision "shell", :path => "package_and_time.sh"
   testnode.vm.provision "shell", inline: "sudo nmcli connection reload; sudo systemctl restart network.service"
   testnode.vm.network "private_network",ip:"10.100.0.11"
        #virtualbox__nat: false
   testnode.vm.host_name = "testnode"
      testnode.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id,"--memory","128"]
        vb.customize ["modifyvm", :id, "--usbehci", "off"]
        vb.customize ["modifyvm", :id, "--usb", "off"]
      end
   testnode.vm.synced_folder ".", "/vagrant", type: "virtualbox"
   end

end

#!/usr/bin/env ruby
# For ubuntu trusty. This script for installing puppet-master puppet-clinet    
# Based on https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html

a=ARGV[0]
alias s system
if ! ARGV[0] 
  puts "Usage: [master client upgrade purge]"
end

def purge
    s('sudo apt-get -f install')
    s('sudo apt-get -y purge puppet-common puppet')
    s('sudo apt-get -y purge puppetmaster*')
    s('sudo rm -rf /etc/puppet')
    s('sudo rm -rf /var/lib/puppet')
end

# install master server
def get_install_master_server
    purge
    s('cd /tmp')
    s('wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb')
    s('sudo apt-get update')
    s('sudo apt-get -y install puppetmaster')
    #s('sudo apt-get -y install puppetmaster-passenger')
end


# install client of puppet
def get_install_client
    purge
    s('cd /tmp')
    s('wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb')
    s('sudo apt-get update')
    s('sudo apt-get -y install puppet')
end

#upgrade
def upgrade
    s('cd /tmp')
    s('sudo puppet resource package puppet ensure=latest')
end

def check
    c = $?.success?
    if c == true
       puts "SUCCESS"
    else
       puts "FAILED"
       exit
    end
end

if  a == 'master'
    get_install_master_server
    check
elsif a == 'client'
    get_install_client
    check
elsif a == 'upgrade'
    upgrade
    check
end 

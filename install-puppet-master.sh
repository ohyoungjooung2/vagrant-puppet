#!/usr/bin/env bash

HNAME=`hostname`
remove(){
  #remove previous packages
  apt-get remove --purge -y puppet*
}

check(){
   RV=$?
   if  [[ $RV != "0" ]]
   then
       echo -e "\e[31m $JOB failed please check"
       exit $RV
   else
       echo -e "\e[34m $JOB successful"
   fi

}

  

check_remove(){
   /usr/bin/which puppet
   sudo rm -rf /var/log/puppet
   JOB="puppet remove check on ubuntu14.04 trusty on $HNAME"
   check
}




install(){
   #install trusty puppet-package
   wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
   sudo dpkg -i puppetlabs-release-trusty.deb
   sudo apt-get update -y
   JOB="INSTALLING PUPPET REPO UBUNTU TRUSTY14.04 on host $HNAME"
   check

}

install_master(){
   sudo apt-get install puppetmaster-passenger -y
   JOB="INSTALLING PUPPET MASTER on host $HNAME"
   check
}

#puppet package install for puppet master
remove
check_remove
install
install_master

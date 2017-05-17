#!/usr/bin/env bash

remove(){
  #remove previous packages
  sudo yum remove  -y puppet*
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
   JOB="puppet remove check on centos7 "
   check
}


install_repo(){
   #install centos7 puppet-package
    sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
   sudo yum update -y
   JOB="INSTALLING PUPPET REPO centos7"
   check
}

install_puppet(){
   #install puppet with yum
   sudo yum install puppet -y
   JOB="INSTALLING PUPPET on centos7"
   check
}


#puppet package install for puppet master
remove
check_remove
install_repo
install_puppet

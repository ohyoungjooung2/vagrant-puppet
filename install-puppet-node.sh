#!/usr/bin/env bash

check_distro(){
   if [[ -e /etc/redhat-release ]]
   then
      DISTRO=$(cat /etc/redhat-release)
   elif [[ -e /usr/bin/lsb_release ]]
   then
      DISTRO=$(lsb_release -d | awk -F ':' '{print $2}')
   elif [[ -e /etc/issue ]]
   then
      DISTRO=$(cat /etc/issue)
   else
      DISTRO=$(cat /proc/version)
   fi  
}
   
   
#Removing old puppet package if it exists
remove(){
  #remove previous packages
  if [[ -e /usr/bin/apt ]]
  then
    sudo apt-get remove --purge -y puppet*
  elif [[ -e /usr/bin/yum ]]
  then
    sudo yum remove -y puppet*
  fi
  
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
   check_distro
   /usr/bin/which puppet
   sudo rm -rf /var/log/puppet
   JOB="puppet remove check $DISTRO"
   check
}

install_repo(){
  check_distro
  if [[ -e /usr/bin/apt ]]
  then
   wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
   sudo dpkg -i puppetlabs-release-trusty.deb
   sudo apt-get update -y
   JOB="INSTALLING PUPPET REPO $DISTRO"
   check
  elif [[ -e /usr/bin/yum ]]
  then
   #install centos7 puppet-package
    sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
    sudo yum update -y
    JOB="INSTALLING PUPPET REPO on $DISTRO"
    check
  fi
}



   



install_node(){
  check_distro
  if [[ -e /usr/bin/apt ]]
  then
   sudo apt-get install puppet -y
   JOB="INSTALLING PUPPET NODE on $DISTRO"
   check
  elif [[ -e /usr/bin/yum ]]
  then
   #install puppet with yum
   sudo yum install puppet -y
   JOB="INSTALLING PUPPET on $DISTRO"
   check
  fi
}

#puppet package install for puppet master
remove
check_remove
install_repo
install_node

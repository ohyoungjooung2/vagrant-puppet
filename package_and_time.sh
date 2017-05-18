#!/usr/bin/env bash

configure_time(){
 echo "now time to Korea(ROK)"
 if [[ -e /usr/bin/apt ]]
 then
    echo 'Asia/Seoul' > /etc/timezone && dpkg-reconfigure --frontend noninteraive tzdata
 elif [[ -e /usr/bin/yum ]]
 then
    timedatectl set-timezone Asia/Seoul
 fi
}


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

install_repo(){
  check_distro
  if [[ -e /usr/bin/apt ]]
  then
   sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get -y autoremove
   JOB="update&&upgrade&&autoremove $DISTRO"
   check
  elif [[ -e /usr/bin/yum ]]
  then
   #update $DISTRO
    sudo yum update -y
    JOB="update $DISTRO"
    check
  fi
}

set_system(){
  C=`grep "set -o vi" /home/vagrant/.bashrc`
  if [[ ! $C ]]
  then
    echo "set -o vi" >> /home/vagrant/.bashrc
    JOB="SETTING VI MODE"
    check 
  fi
}

configure_time
install_repo
set_system

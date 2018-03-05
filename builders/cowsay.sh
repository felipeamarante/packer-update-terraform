#!/bin/bash


function platformize(){

#Rudimentar OS detection, please let me know if you have a better one#
 if hash lsb_release; then
   echo "Ubuntu Server OS detected"
   export PLAT="ubuntu"


elif hash yum; then
  echo "Amz Linux detected"
  export PLAT="amz"

 else
   echo "Unsupported Release, go away dude"
   exit 1

 fi
}



function install(){

if [ ${PLAT} = "ubuntu" ]; then

  apt-get -y install figlet
  figlet "Don't do Drugs"


elif [ ${PLAT} = "amz" ]; then
  yum -y install figlet
  figlet I Love AWS

fi

}


platformize
install

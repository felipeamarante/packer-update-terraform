#!/bin/bash -xe

## Code Deploy Setup One liner ##

#DEP - jq ruby2.0



function installdep(){

if [ ${PLAT} = "ubuntu" ]; then

  apt-get -y update
  apt-get -y install jq awscli ruby2.0


elif [ ${PLAT} = "amz" ]; then
  yum -y update
  yum install -y aws-cli ruby jq

fi

}



function mapBucket(){

 if [ ! -z "$1" ]; then

    case $1 in
      "us-east-1")
        export BUCKETNAME="aws-codedeploy-us-east-1"

      ;;

      "us-west-1")
        export BUCKETNAME="aws-codedeploy-us-west-1"

      ;;

      "us-west-2")
        export BUCKETNAME="aws-codedeploy-us-west-2"

      ;;

      "ap-south-1")
        export BUCKETNAME="aws-codedeploy-ap-south-1"

      ;;

      "ap-northeast-2")
        export BUCKETNAME="aws-codedeploy-ap-northeast-2"

      ;;

      "ap-southeast-1")
        export BUCKETNAME="aws-codedeploy-ap-southeast-1"

      ;;

      "ap-southeast-2")
        export BUCKETNAME="aws-codedeploy-ap-southeast-2"

      ;;

      "northeast-1")
        export BUCKETNAME="aws-codedeploy-ap-northeast-1"

      ;;

      "eu-central-1")
        export BUCKETNAME="aws-codedeploy-eu-central-1"

      ;;

      "eu-west-1")
        export BUCKETNAME="aws-codedeploy-eu-west-1"

      ;;

      "sa-east-1")
        export BUCKETNAME="aws-codedeploy-sa-east-1"

      ;;

      *)
        echo "Code deploy not valid region"
      ;;

    esac
  else
  echo "Empty/Null Variable"
  exit 1

  fi
}






function platformize(){

#Rudimentar OS detection, please let me know if you have a better one#
 if hash lsb_release; then
   echo "Ubuntu Server OS detected"
   export PLAT="ubuntu"


elif hash yum; then
  echo "Amz Linux detected"
  export PLAT="amz"

 else
   echo "Unsupported Release"
   exit 1

 fi
}


function execute(){

if [ ${PLAT} = "ubuntu" ]; then

  cd /home/ubuntu

  wget https://${BUCKETNAME}.s3.amazonaws.com/latest/install
  chmod +x ./install
  if ./install auto; then
    echo "Instalation Completed"
    exit 0
  else
    echo "Instalation Script Failed, please investigate"
    exit 1
  fi

elif [ ${PLAT} = "amz" ]; then

  cd /home/ec2-user

  wget https://${BUCKETNAME}.s3.amazonaws.com/latest/install
  chmod +x ./install

    if ./install auto; then
      echo "Instalation Completed"
      exit 0
    else
      echo "Instalation Script Failed, please investigate"
      exit 1
    fi

else
  echo "Unsupported Platform ''${PLAT}''"
fi

}


platformize
installdep
REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")
mapBucket ${REGION}
execute

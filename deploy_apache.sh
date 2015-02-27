#!/bin/bash

# Source the default properties file if it exists
PROPERTIES_FILE="defaults.properties"
[[ -f $PROPERTIES_FILE ]] && source $PROPERTIES_FILE

# Read flags
while getopts ":p:a:" opt; do
  case $opt in
    h)
      echo "This deploys Apache on a new amazon instance."
      echo "Usage:"
      echo "\t ./deploy_apache.sh -p permission_file.pem -a 123.45.67.89"
      echo "\nWhere -p is the location of the permissions file and -a is the address of the amazon instance."
      ;;
    p)
      PERMISSIONS_FILE_LOCATION=$OPTARG
      ;;
    a)
      ADDRESS=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Main action
#if [ -z ${PERMISSIONS_FILE_LOCATION+x} ] && [ -z ${ADDRESS+x}];
  #then echo "Permission file and/or address is missing.";
  #else
  echo "Connecting to $ADDRESS using $PERMISSIONS_FILE_LOCATION..."
  ssh -t -i $PERMISSIONS_FILE_LOCATION ec2-user@$ADDRESS 'sudo yum update -y; curl "https://raw.githubusercontent.com/liamitus/aws/master/setup_apache.sh" | sudo sh'
  echo "Apache setup is almost complete."
  echo "Setting up Apache permissions..."
  ssh -t -i $PERMISSIONS_FILE_LOCATION ec2-user@$ADDRESS 'curl "https://raw.githubusercontent.com/liamitus/aws/master/setup_apache_permissions.sh" | sudo sh'
#fi

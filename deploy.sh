#!/bin/bash

# Source the default properties file if it exists
PROPERTIES_FILE="defaults.properties"
[[ -f $PROPERTIES_FILE ]] && source $PROPERTIES_FILE

# Helper function to ssh into the server and run an arbitrary string:
run () {
  ssh -t -i $PERMISSIONS_FILE_LOCATION $SSH_USERNAME@$ADDRESS $1
}

run "sudo yum update -y"
run "sudo yum install git -y; curl \"https://raw.githubusercontent.com/liamitus/aws/master/deploy_from_github.sh\" | sudo sh -s $GITHUB_USER $GITHUB_REPO"
run "sudo cp -r $GITHUB_REPO/* $SITE_DIR/; sudo rm -rf -- $SITE_DIR/*"
run "sudo service httpd restart"

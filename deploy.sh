#!/bin/bash

# Source the default properties file if it exists
PROPERTIES_FILE="defaults.properties"
[[ -f $PROPERTIES_FILE ]] && source $PROPERTIES_FILE

ssh -t -i $PERMISSIONS_FILE_LOCATION ec2-user@$ADDRESS "sudo yum install git -y; curl \"https://raw.githubusercontent.com/liamitus/aws/master/deploy_from_github.sh\" | sudo sh -s $GITHUB_USER $GITHUB_REPO"

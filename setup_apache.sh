sudo yum update -y
sudo yum groupinstall -y "Web Server"
sudo service httpd start
sudo groupadd www
sudo usermod -a -G www ec2-usermod
echo "Please exit the terminal, reconnect, and then run the following:"
echo "curl \"https://raw.githubusercontent.com/liamitus/aws/master/setup_apache_permissions.sh\" | sudo sh"

sudo yum install git -y
rm -R $2
git clone https://github.com/$1/$2.git
sudo cp $2/* /var/www/html/
sudo service httpd restart

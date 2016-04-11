#!/usr/bin/env bash

echo "---------------------------------------------------------------"
echo " "
echo " "
echo "      WOOBOX PROVISION STARTS"
echo " "
echo " "
echo "---------------------------------------------------------------"


echo "---------------------------------------------------------------"
echo "UPDATING CentOS 7: INSTALLING BASIC DEPENDENCIES"
echo "---------------------------------------------------------------"
yum -y update
yum -y install fontconfig
yum -y install unzip
yum -y install nano
yum -y install wget

echo "---------------------------------------------------------------"
echo "INSTALLING GIT"
echo "---------------------------------------------------------------"
sudo yum -y install git


echo "----------------------------------------------------------------"
echo "INSTALLING NGINX"
echo "----------------------------------------------------------------"
yum -y install epel-release
yum -y install nginx
systemctl enable nginx.service
systemctl start nginx.service 
systemctl status nginx.service
systemctl stop nginx.service
systemctl status nginx.service
#service nginx stop
#
#cp /home/vagrant/config/nginx.conf /etc/nginx/nginx.conf
cp /home/vagrant/config/site.conf.template /etc/nginx/conf.d/sites.conf
#
systemctl start nginx.service
systemctl status nginx.service

echo "---------------------------------------------------------------"
echo "INSTALLING PHP"
echo "---------------------------------------------------------------"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php56w-fpm php56w-opcache php56w-mysql php56w-cli
echo "Installing PHP extensions"
yum -y install php56w-gd php56w-mcrypt
systemctl enable php-fpm.service
systemctl start php-fpm.service
#
echo "---------------------------------------------------------------"
echo "INSTALLING MYSQL"
echo "---------------------------------------------------------------"
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y update
yum -y install mysql-server
systemctl start mysqld
#apt-get install debconf-utils -y
#debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
#debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
#apt-get install mysql-server -y
#mysql -proot --execute="grant all privileges on *.* to 'root'@'%' identified by '1234';"
#cp /home/vagrant/config/my.cnf /etc/mysql/my.cnf
#service mysql restart
#
#echo "---------------------------------------------------------------"
#echo "INSTALLING COMPOSER"
#echo "---------------------------------------------------------------"
#php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
#php composer-setup.php --install-dir=/bin --filename=composer
#
#
#echo "---------------------------------------------------------------"
#echo "INSTALLING REDIS"
#echo "---------------------------------------------------------------"
#apt-get install -y redis-server
#
#echo "---------------------------------------------------------------"
#echo "INSTALLING NODEJS"
#echo "---------------------------------------------------------------"
#curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
#sudo apt-get install -y nodejs
#
#echo "---------------------------------------------------------------"
#echo "INSTALLING RUBY"
#echo "---------------------------------------------------------------"
#apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev -y
#apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev -y
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
#\curl -sSL https://get.rvm.io | bash -s stable
#apt-get install ruby2.0 ruby2.0-dev -y
#rvm use --default 2.0
#echo "---------------------------------------------------------------"
#echo "USING RUBY VERSION"
#echo "---------------------------------------------------------------"
#ruby -v
echo "---------------------------------------------------------------"
echo "INSTALLING MAILHOG"
echo "---------------------------------------------------------------"
wget https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64
mv MailHog_linux_amd64 /usr/bin/mailhog
chmod 755 /usr/bin/mailhog

echo "---------------------------------------------------------------"
echo "SETTING LOCALE"
echo "---------------------------------------------------------------"
echo "export LC_ALL=en_US.UTF-8" >> /etc/profile
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
echo "---------------------------------------------------------------"
echo " WOOBOX PROVISION HAS BEEN COMPLETED"
echo "---------------------------------------------------------------"

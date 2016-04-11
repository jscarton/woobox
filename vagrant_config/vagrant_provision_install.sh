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
yum -y install epel-release

echo "---------------------------------------------------------------"
echo "INSTALLING GIT"
echo "---------------------------------------------------------------"
sudo yum -y install git

echo "----------------------------------------------------------------"
echo "INSTALLING APACHE"
echo "----------------------------------------------------------------"
yum -y install httpd
systemctl enable httpd.service
systemctl start httpd.service 

echo "---------------------------------------------------------------"
echo "INSTALLING PHP"
echo "---------------------------------------------------------------"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php56w php56w-opcache
echo "Installing PHP extensions"
yum -y install php56w-gd php56w-mcrypt php56w-mysql php56w-cli
cp /home/vagrant/config/index.php /var/wwww/html/index.php
#
echo "---------------------------------------------------------------"
echo "INSTALLING MYSQL"
echo "---------------------------------------------------------------"
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y update
yum -y install mysql-server
systemctl enable mysqld
systemctl start mysqld

echo "---------------------------------------------------------------"
echo "INSTALLING COMPOSER"
echo "---------------------------------------------------------------"
php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php --install-dir=/bin --filename=composer

echo "---------------------------------------------------------------"
echo "INSTALLING REDIS"
echo "---------------------------------------------------------------"
yum -y install redis
systemctl enable redis.service
systemctl start redis.service
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
echo "FIXING LOCALE"
echo "---------------------------------------------------------------"
echo "export LC_ALL=en_US.UTF-8" >> /etc/profile
echo "export LANG=en_US.UTF-8" >> /etc/profile
echo "export LANGUAGE=en_US.UTF-8" >> /etc/profile
echo "export LC_COLLATE=C" >> /etc/profile
echo "export LC_CTYPE=en_US.UTF-8" >> /etc/profile
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
echo "---------------------------------------------------------------"
echo " WOOBOX PROVISION HAS BEEN COMPLETED"
echo "---------------------------------------------------------------"

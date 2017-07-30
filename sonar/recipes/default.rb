#
# Cookbook:: sonar
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package 'wget' do
action :install
end

rpm_package 'jenkins' do
source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
action :install
end

execute 'update' do
command 'yum update -y'
end

package %w(mysql-server java-1.8.0-openjdk)do
  action :install
end

service 'mysqld' do
action :start
end

include_recipe 'sonar::mysql_secure_install'

sonar_install 'sonar_install' do
title 'Installing sonar'
end

template '/opt/sonarqube/conf/sonar.properties' do
  source 'sonar.properties.erb'
  mode '0755'
end


execute 'script' do
cwd '/opt/sonarqube/bin/linux-x86-64'
command 'sudo ./sonar.sh start'
end

template '/etc/init.d/sonar' do
  source 'sonar.erb'
  mode '0755'
end

link '/usr/bin/sonar' do
to '/opt/sonarqube/bin/linux-x86-64/sonar.sh'
link_type :symbolic
end

execute 'chkconfig' do
command 'sudo chkconfig --add sonar'
end

service 'sonar' do
action :stop
end
service 'sonar' do
action :start
end
service 'sonar' do
action :restart
end




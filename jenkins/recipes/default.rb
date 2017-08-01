#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package 'java-1.8.0-openjdk' do
action :install
end

remote_file '/etc/yum.repos.d/jenkins.repo' do
  source 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
  user 'root'
  mode '0755'
  action :create
end

execute 'import verification key' do
command 'sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

package 'jenkins' do
action :install
end

service 'jenkins.service' do 
action [ :enable, :start ]
end



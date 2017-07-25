#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


apt_update 'update' do
   action :update
end

package 'mysql-server' do
  action :install
  provider Chef::Provider::Package::Apt
  #version '5.5.57-0ubuntu0.14.04.1'
end

include_recipe 'mysql::secure_install'


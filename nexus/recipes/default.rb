#
# Cookbook:: nexus
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


package %w(java-1.8.0-openjdk.x86_64 wget) do 
action :install
end

directory "node['nexus']['dirname']" do
action :create
end


user 'nexus' do
home '/home/nexus'
shell '/bin/bash'
action :create
end

nexus_tar 'nexus_install' do
title 'nexus'
end

template "#{node['nexus']['o_path']}/nexus.rc" do
source 'nexus.rc.erb'
end

template "#{node['nexus']['path']}/nexus.vmoptions" do
source 'nexus.vmoptions.erb'
end

link '/etc/init.d/nexus' do
  to '/app/nexus/bin/nexus'
  link_type :symbolic
  action :create
end

execute 'chkconfig' do
command <<-EOH
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on
EOH
end

service 'nexus' do
action :start
end

#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


apt_update 'update' do
   action :update
end

package 'tomcat7' do
  action :install
  provider Chef::Provider::Package::Apt
end

template "/etc/default/#{node['tomcat7']['configfile']}" do
  source 'tomcat7.erb'
 variables({
    :username => "#{node['tomcat7']['username']}"
    :groupname => "#{node['tomcat7']['groupname']}"
    })
  mode '777'
  owner 'root'
  group 'root' 
end

template "/etc/tomcat7/#{node['tomcat7']['serverconfig']}" do
   source 'server.xml.erb'
  variables({
      :port => "#{node['tomcat7']['port']}"
     })
   mode '777'
   owner 'root'
   group 'root'
end



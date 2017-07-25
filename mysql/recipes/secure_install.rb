template "/root/.my.cnf" do
source 'my.cnf.erb'
variables(
  :username => "#{node['mysql']['username']}" ,
  :userpassword => "#{node['mysql']['userpassword']}"
  )
 mode '777'
 owner 'root'
 group 'root'
end


bash 'extract_module' do
  code <<-EOH
mysql -u root -e "CREATE USER '#{node['mysql']['name']}' IDENTIFIED BY '#{node['mysql']['password']}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '#{node['mysql']['name']}';"
mysql -u root -e "FLUSH PRIVILEGES;"
 EOH
end


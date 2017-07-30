property :title
action :start do

bash 'extract_module' do
  code <<-EOH
cd /opt
sudo wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.0.zip
sudo yum install unzip -y
sudo unzip sonarqube-6.0.zip
mv sonarqube-6.0 sonarqube
EOH
end
end

abort 'This cookbook is only usable with Fedora' unless node['platform'] == 'fedora'

#Ruby 
packages =  ["jq","gcc-c++","patch","readline","readline-devel","zlib","zlib-devel","libyaml-devel","libffi-devel","openssl-devel","make","bzip2","autoconf","automake","libtool","bison","sqlite-devel"]
package packages do
  action :install
end 



remote_file '/home/operry/chef-cache/rvm-installer' do
  source 'https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer'
  owner 'operry'
  group 'operry'
  mode '0750'
  action :create
end

execute 'setup rvm gpg 1 ' do 
  command 'curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -  '
  cwd '/usr/local'
  not_if { File.exists?("/etc/profile.d/rvm.sh") }
end
  
execute 'setup rvm gpg 2' do 
  command 'curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import - '
  cwd '/usr/local'
  not_if { File.exists?("/etc/profile.d/rvm.sh") }
end

execute 'setup rvm' do 
  command 'cat /home/operry/chef-cache/rvm-installer | bash -s stable  '
  cwd '/usr/local'
  not_if { File.exists?("/etc/profile.d/rvm.sh") }
end


directory '/home/operry/chef-cache' do 
  owner 'operry'
  group 'operry'
  mode '0755'
  action :create
end

remote_file '/home/operry/chef-cache/slack-4.1.2-0.1.fc21.x86_64.rpm' do
  source 'https://downloads.slack-edge.com/linux_releases/slack-4.1.2-0.1.fc21.x86_64.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/slack-4.1.2-0.1.fc21.x86_64.rpm' do
  action :install
end 

remote_file '/usr/local/bin/kubectl' do
  source 'https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl'
  owner 'operry'
  group 'operry'
  mode '0755'
  action :create
end

package 'bash-completion' do
  action :install
end

package 'docker' do
  action :install
end

group 'docker' do
  action :modify
  members 'operry'
  append true
end


yum_repository 'vscode' do
  description 'Visual Studio Code'
  baseurl 'https://packages.microsoft.com/yumrepos/vscode'
  gpgkey 'https://packages.microsoft.com/keys/microsoft.asc'
  action :create
end

package node['vscode']['insiders'] ? 'code-insiders' : 'code'

remote_file '/usr/local/bin/kind' do
  source 'https://github.com/kubernetes-sigs/kind/releases/download/v0.6.0/kind-linux-amd64'
  owner 'operry'
  group 'operry'
  mode '0755'
  action :create
end


### golang 

remote_file '/home/operry/chef-cache/go1.13.4.linux-amd64.tar.gz' do
  source 'https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

execute '/home/operry/chef-cache/go1.13.4.linux-amd64.tar.gz' do
  command 'tar xzvf /home/operry/chef-cache/go1.13.4.linux-amd64.tar.gz'
  cwd '/usr/local'
  not_if { File.exists?("/usr/local/go/bin/go") }
end


remote_file '/home/operry/chef-cache/keepass-2.42.1-3.fc31.x86_64.rpm' do
  source 'https://kojipkgs.fedoraproject.org//packages/keepass/2.42.1/3.fc31/x86_64/keepass-2.42.1-3.fc31.x86_64.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/keepass-2.42.1-3.fc31.x86_64.rpm' do
  action :install
end 


remote_file '/home/operry/chef-cache/LibreOffice_6.3.3_Linux_x86-64_rpm.tar.gz' do
  source 'https://download.documentfoundation.org/libreoffice/stable/6.3.3/rpm/x86_64/LibreOffice_6.3.3_Linux_x86-64_rpm.tar.gz'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
  not_if { File.exists?("/usr/bin/libreoffice6.3") }
end

execute '/home/operry/chef-cache/LibreOffice_6.3.3_Linux_x86-64_rpm.tar.gz' do
  command 'tar xzvf /home/operry/chef-cache/LibreOffice_6.3.3_Linux_x86-64_rpm.tar.gz'
  cwd '/home/operry/chef-cache'
  not_if { File.exists?("/usr/bin/libreoffice6.3") }
end


execute 'install libre' do
  command 'dnf install -y /home/operry/chef-cache/LibreOffice_6.3.3.2_Linux_x86-64_rpm/RPMS/*.rpm'
  not_if { File.exists?("/usr/bin/libreoffice6.3") }
end

remote_file '/home/operry/chef-cache/helm-v3.0.0-linux-amd64.tar.gz' do
  source 'https://get.helm.sh/helm-v3.0.0-linux-amd64.tar.gz'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
  not_if { File.exists?("/usr/local/bin/helm") }
end

execute '/home/operry/chef-cache/helm-v3.0.0-linux-amd64.tar.gz' do
  command 'tar xzvf /home/operry/chef-cache/helm-v3.0.0-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm && chmod 755 /usr/local/bin/helm '
  cwd '/home/operry/chef-cache'
  not_if { File.exists?("/usr/local/bin/helm") }
end

remote_file '/home/operry/chef-cache/draw.io-x86_64-12.2.2.rpm' do
  source 'https://github.com/jgraph/drawio-desktop/releases/download/v12.2.2/draw.io-x86_64-12.2.2.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/draw.io-x86_64-12.2.2.rpm' do
  action :install
end 

package 'tomboy' do
  action :install
end 


remote_file '/home/operry/chef-cache/zoom_x86_64.rpm' do
  source 'https://zoom.us/client/latest/zoom_x86_64.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/zoom_x86_64.rpm' do 
  action :install
end  


remote_file '/home/operry/chef-cache/terraform_0.12.18_linux_amd64.zip' do
  source 'https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

execute '/home/operry/chef-cache/terraform_0.12.18_linux_amd64.zip' do
  command 'unzip /home/operry/chef-cache/terraform_0.12.18_linux_amd64.zip && mv terraform /usr/local/bin/terraform && chmod 755 /usr/local/bin/terraform '
  cwd '/home/operry/chef-cache'
  not_if { File.exists?("/usr/local/bin/terraform") }
end


remote_file '/home/operry/chef-cache/awscli-bundle.zip' do
  source 'https://s3.amazonaws.com/aws-cli/awscli-bundle.zip'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

execute '/home/operry/chef-cache/awscli-bundle.zip' do
  command 'unzip /home/operry/chef-cache/awscli-bundle.zip && sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws '
  cwd '/home/operry/chef-cache'
  not_if { File.exists?("/usr/local/bin/aws") }
end

yum_repository 'virtualbox' do
  description 'virtualbox'
  baseurl 'http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch'
  gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
  action :create
end

packages = %w(VirtualBox-6.0 binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras libxkbcommon)
package packages do
  action :install
end 

remote_file '/home/operry/chef-cache/chefdk-4.6.35-1.el7.x86_64.rpm' do
  source 'https://packages.chef.io/files/stable/chefdk/4.6.35/el/7/chefdk-4.6.35-1.el7.x86_64.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/chefdk-4.6.35-1.el7.x86_64.rpm' do 
  action :install
end  

remote_file '/home/operry/chef-cache/vagrant_2.2.6_x86_64.rpm' do
  source 'https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/vagrant_2.2.6_x86_64.rpm' do 
  action :install
end  

package 'openvpn' do 
  action :install
end

remote_file '/home/operry/chef-cache/rpmfusion-free-release-31.noarch.rpm' do
  source 'https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-31.noarch.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

remote_file '/home/operry/chef-cache/rpmfusion-nonfree-release-31.noarch.rpm' do
  source 'https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-31.noarch.rpm'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

package '/home/operry/chef-cache/rpmfusion-nonfree-release-31.noarch.rpm' do 
  action :install
end

package '/home/operry/chef-cache/rpmfusion-free-release-31.noarch.rpm' do 
  action :install
end

package 'ffmpeg' do
  action :install
end


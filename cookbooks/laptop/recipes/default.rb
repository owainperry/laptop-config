abort 'This cookbook is only usable with Fedora' unless node['platform'] == 'fedora'

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

cookbook_file '/home/operry/.bashrc' do
  source 'bashrc'
  owner 'operry'
  group 'operry'
  mode '0644'
  action :create
end

cookbook_file '/home/operry/.bash_profile' do
  source 'bash_profile'
  owner 'operry'
  group 'operry'
  mode '0644'
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
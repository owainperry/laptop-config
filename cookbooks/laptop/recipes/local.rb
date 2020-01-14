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

  cookbook_file '/home/operry/.alias' do
    source 'alias'
    owner 'operry'
    group 'operry'
    mode '0640'
    action :create
  end
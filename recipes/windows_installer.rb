#
# Cookbook Name:: omnibus_updater
# Recipe:: windows_installer
#
# 2015 Joe Miller DevOps@paraport.com
#

cookbook_file "#{Chef::Config[:file_cache_path]}/Update-ChefClient.ps1" do
  source 'Update-ChefClient.ps1'
  action :create
end

Chef::Log.warn("Beginning upgrade of Chef to version #{node[:omnibus_updater][:version]}. Upgrade could take 5-10 minutes to complete...")
execute 'Update-ChefClient' do
  command ".\\Update-ChefClient.ps1 #{node[:omnibus_updater][:version]}"
  cwd     "#{Chef::Config[:file_cache_path]}"
  action  :run
end

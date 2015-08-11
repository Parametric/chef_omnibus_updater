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

execute 'Update-ChefClient' do
  command "powershell -executionpolicy bypass -command #{Chef::Config[:file_cache_path]}\\Update-ChefClient.ps1 #{node[:omnibus_updater][:version]}"
  action  :run
end

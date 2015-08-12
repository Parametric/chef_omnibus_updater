#
# Cookbook Name:: omnibus_updater
# Recipe:: windows_installer
#
# 2015 Joe Miller DevOps@paraport.com
#

# Copy script from cookbook
cookbook_file "#{Chef::Config[:file_cache_path]}/Update-ChefClient.ps1" do
  source 'Update-ChefClient.ps1'
  action :create
end

# Execute script with the version you are upgrading to
execute 'Update-ChefClient' do
  command "powershell -executionpolicy bypass -command #{Chef::Config[:file_cache_path]}\\Update-ChefClient.ps1 #{node[:omnibus_updater][:version]}"
  action  :run
end

# Allow the installer to finish.  Chef ends before it is complete.
Chef::Log.warn 'Installation finishing (~1 min)...'
sleep 60

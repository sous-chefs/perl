#
# Cookbook Name:: perl
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unless node['platform'] == 'windows'
	node['perl']['packages'].each do |perl_pkg|
	  package perl_pkg
	end

	cpanm = node['perl']['cpanm'].to_hash
	root_group = (node[:platform] == "mac_os_x") ? "admin" : "root"
	remote_file cpanm['path'] do
	  source cpanm['url']
	  checksum cpanm['checksum']
	  owner "root"
	  group root_group
	  mode 0755
	end
else
	installer = "strawberry-perl-#{node['perl']['maj_version']}.#{node['perl']['min_version']}.#{node['perl']['sub_version']}-#{node['perl']['bitness']}.msi"

	tempdir = ENV['TEMP']

	if tempdir.nil? || tempdir == ''
		tempdir = 'C:\\temp\\'

		#directory 'C:\\temp\\' do
		directory tempdir do
	 		action :create
	 		inherits true
	 		owner "administrator"
	 		group "administrators"
	 	end
	end

	directory node['perl']['install_dir'] do
		action :create
		recursive true
		inherits true
		owner "administrator"
		group "administrators"
	end

	remote_file "#{tempdir}\\#{installer}" do
		source "https://strawberry-perl.googlecode.com/files/#{installer}"
		action :create
		owner "administrator"
		group "administrators"
		mode 0774
	end

	execute "Install StrawberryPerl" do
		command "msiexec /qn /i #{tempdir}\\#{installer} INSTALLDIR=#{node['perl']['install_dir']} PERL_PATH=YES"
		not_if { File.exists?("#{node['perl']['install_dir']}\\perl\\bin\\perl.exe") }
	end

	execute "Add Perl to PATH" do
		command "setx /M path \"#{node['perl']['install_dir']}perl\\bin;%path%\""
	end

	## Going to try the windows_path primitive
	## This appears to only Append to %PATH%, when I want it to Prepend
	#windows_path "#{node['perl']['install_dir']}perl\\bin" do
	#	action :add
	#end

end

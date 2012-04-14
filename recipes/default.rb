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

package "perl" do
  action :upgrade
end

if %w{redhat centos fedora scientific oracle amazon}.include?(node['platform'])
  package "perl-CPAN" do
    action :upgrade
  end
end

libwww_perl = case node[:platform]
  when "redhat","centos","fedora","scientific","oracle","amazon"
    "perl-libwww-perl"
  when "arch"
    "perl-libwww"
  when "debian","ubuntu","mint"
    "libwww-perl"
  end

package libwww_perl do
  action :upgrade
end

libperl_dev = case node[:platform]
  when "redhat","centos","fedora","scientific","oracle","amazon"
    "perl-devel"
  when "ubuntu","debian","mint" 
    "libperl-dev"
  when "arch"
    nil
  end

package libperl_dev do
  action :upgrade
end unless libperl_dev.nil?

directory "/root/.cpan" do
  owner "root"
  group "root"
  mode 0750
end

cookbook_file "CPAN-Config.pm" do
  path case node[:platform]
    when "redhat","centos","scientific","oracle"
      if node[:platform_version].to_f >= 6
        "/usr/share/perl5/CPAN/Config.pm"
      else
        "/usr/lib/perl5/#{node[:languages][:perl][:version]}/CPAN/Config.pm"
      end
    when "amazon","fedora"
      # FIXME: need platform_version tests for fedora and amazon
      "/usr/share/perl5/CPAN/Config.pm"
    when "arch"
      "/usr/share/perl5/core_perl/CPAN/Config.pm"
    when "debian","ubuntu","mint"
      "/etc/perl/CPAN/Config.pm"
    end
  source "Config-#{node[:languages][:perl][:version]}.pm"
  owner "root"
  group "root"
  mode 0644
end

cookbook_file "/usr/local/bin/cpan_install" do
  source "cpan_install"
  owner "root"
  group "root"
  mode 0755
end

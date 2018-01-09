#
# Cookbook:: perl
# Recipe:: default
#
# Copyright:: 2009-2017, Chef Software, Inc.
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

case node['platform']
when 'windows'
  # https://chocolatey.org/packages/StrawberryPerl
  chocolatey_package 'strawberryperl'

  windows_path 'C:\\Strawberry\\perl\\bin' do
    action :add
  end
else
  package node['perl']['packages']

  cpanm = node['perl']['cpanm'].to_hash

  directory File.dirname(cpanm['path']) do
    recursive true
  end

  remote_file cpanm['path'] do
    source cpanm['url']
    checksum cpanm['checksum']
    owner 'root'
    group node['root_group']
    mode '0755'
    sensitive cpanm['suppress_diff']
  end
end

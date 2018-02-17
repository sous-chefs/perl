#
# Cookbook:: perl
# Attributes:: default
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

case node['platform_family']
when 'rhel', 'fedora', 'amazon'
  default['perl']['packages'] = %w(perl perl-CPAN)

  default['perl']['packages'] = case node['platform_version'].to_i
                                when 5
                                  %w(perl)
                                else
                                  %w(perl perl-devel perl-CPAN)
                                end
when 'debian'
  default['perl']['packages'] = %w(perl libperl-dev)
when 'windows'
  default['perl']['version'] = '5.26.1.1'
else
  default['perl']['packages'] = %w(perl)
end

default['perl']['cpanm']['url'] = 'https://raw.githubusercontent.com/miyagawa/cpanminus/1.7043/cpanm'
default['perl']['cpanm']['checksum'] = 'd2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539'
default['perl']['cpanm']['suppress_diff'] = false

default['perl']['cpanm']['path'] = if node['platform_family'] == 'windows'
                                     'C:\\strawberry\\perl\\bin\\cpanm'
                                   else
                                     '/usr/local/bin/cpanm'
                                   end

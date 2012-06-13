#
# Cookbook Name:: perl 
# Attributes:: default
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

case node['platform']
when "redhat","centos","scientific","amazon","oracle","fedora"
  default['perl']['packages'] = %w{ perl perl-libwww-perl perl-CPAN }
  default['perl']['cpan_path'] = "/usr/share/perl5/CPAN/Config.pm"
  case node['platform_version'].to_i
  when 5
    default['perl']['packages'] = %w{ perl perl-libwww-perl  }
    default['perl']['cpan_path'] = "/usr/lib/perl5/5.8.8/CPAN/Config.pm"
  when 6
    default['perl']['packages'] = %w{ perl perl-libwww-perl perl-CPAN }
    default['perl']['cpan_path'] = "/usr/share/perl5/CPAN/Config.pm"
  end
when "debian","ubuntu","mint"
  default['perl']['packages'] = %w{ perl libperl-dev }
  default['perl']['cpan_path'] = "/etc/perl/CPAN/Config.pm"
when "arch"
  default['perl']['packages'] = %w{ perl perl-libwww }
  default['perl']['cpan_path'] = "/usr/share/perl5/core_perl/CPAN/Config.pm"
else
  default['perl']['packages'] = %w{ perl libperl-dev }
  default['perl']['cpan_path'] = "/etc/perl/CPAN/Config.pm"
end

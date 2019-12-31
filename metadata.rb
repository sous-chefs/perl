name 'perl'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs perl and provides a resource for maintaining CPAN modules'
version '7.0.1'

%w(ubuntu debian linuxmint redhat centos amazon scientific oracle fedora windows zlinux suse opensuse opensuseleap).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/perl'
issues_url 'https://github.com/chef-cookbooks/perl/issues'
chef_version '>= 13.4'

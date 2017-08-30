name 'perl'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs perl and provides a resource for maintaining CPAN modules'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '5.2.1'

recipe 'perl', 'Installs perl and adds a provider to install cpan modules'

%w(ubuntu debian mint redhat centos amazon scientific oracle fedora arch windows zlinux suse opensuse opensuseleap).each do |os|
  supports os
end

depends 'windows', '>= 3.0'

source_url 'https://github.com/chef-cookbooks/perl'
issues_url 'https://github.com/chef-cookbooks/perl/issues'
chef_version '>= 12.7' if respond_to?(:chef_version)

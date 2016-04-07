name 'perl'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs perl and provides a resource for maintaining CPAN modules'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.0.0'

recipe 'perl', 'Installs perl and adds a provider to install cpan modules'

%w(ubuntu debian mint redhat centos amazon scientific oracle fedora arch windows ).each do |os|
  supports os
end

depends 'windows'

source_url 'https://github.com/chef-cookbooks/perl' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/perl/issues' if respond_to?(:issues_url)

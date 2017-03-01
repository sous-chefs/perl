apt_update 'update'

include_recipe 'perl::default'

unless platform?('windows')
  include_recipe 'build-essential::default' # required to compile modules

  cpan_module 'Install test module' do
    module_name 'Test::MockModule'
    version '>= 0.05'
    action :install
  end

  cpan_module 'Uninstall test module' do
    module_name 'Test::MockModule'
    action :uninstall
  end

  # cpan_module 'Test::MockModule' do
  #   version '>= 0.05'
  #   action [:install]
  # end
end

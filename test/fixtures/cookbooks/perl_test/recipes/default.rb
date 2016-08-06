apt_update 'update' if platform_family?('debian')

include_recipe 'perl::default'

unless platform?('windows')
  include_recipe 'build-essential::default' # required to compile modules

  cpan_module 'Test::MockModule' do
    version '>= 0.05'
    action [:install]
  end

  cpan_module 'Test::MockModule' do
    action [:uninstall]
  end

  # cpan_module 'Test::MockModule' do
  #   version '>= 0.05'
  #   action [:install]
  # end
end

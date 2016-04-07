include_recipe 'perl::default'

unless platform?('windows')
  cpan_module 'Test::MockModule' do
    version '>= 0.05'
    action [:install]
  end

  cpan_module 'Test::MockModule' do
    action [:uninstall]
  end

  cpan_module 'Test::MockModule' do
    version '>= 0.05'
    action [:install]
  end
end

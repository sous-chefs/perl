if defined?(ChefSpec)
  # config
  def install_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_module, :install, resource_name)
  end

  def uninstall_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_module, :uninstall, resource_name)
  end
end

if defined?(ChefSpec)
  # config
  def create_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_module, :create, resource_name)
  end

  def delete_cpan_module(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cpan_module, :delete, resource_name)
  end
end

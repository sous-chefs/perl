require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    # Provider for cpan_module lwrp
    class CpanModule < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      include PerlCookbook::Helpers

      action :create do
        execute "CPAN :create #{new_resource.name}" do
          cwd current_working_dir
          command cpanm_install_cmd
          environment 'HOME' => current_working_dir, 'PATH' => '/usr/local/bin:/usr/bin:/bin'
          not_if module_exists
        end
      end

      action :delete do
        execute "CPAN :delete #{new_resource.name}" do
          cwd current_working_dir
          command cpanm_uninstall_cmd
          only_if module_exists
        end
      end
    end
  end
end

require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    # Provider for cpan_module lwrp
    class CpanModule < Chef::Provider::LWRPBase
      use_inline_resources

      def whyrun_supported?
        true
      end

      # Mix in helpers from libraries/helpers.rb
      include PerlCookbook::Helpers

      action :install do
        execute "CPAN :install #{new_resource.name}" do
          cwd current_working_dir
          command cpanm_install_cmd
          environment 'HOME' => current_working_dir, 'PATH' => '/usr/local/bin:/usr/bin:/bin'
          not_if { module_exists_new_enough }
        end
      end

      action :uninstall do
        execute "CPAN :uninstall #{new_resource.name}" do
          cwd current_working_dir
          command cpanm_uninstall_cmd
          only_if module_exists
        end
      end
    end
  end
end

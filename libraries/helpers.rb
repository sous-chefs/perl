module PerlCookbook
  # A set of helpers to use in the perl cookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def module_exists
      return false if new_resource.force
      "perl -m#{new_resource.name} -e ';' > /dev/null 2>&1"
    end

    def cpanm_install_cmd
      @cmd = ''
      @cmd = "#{node['perl']['cpanm']['path']} "
      @cmd += '--quiet ' unless new_resource.verbose
      @cmd += '--force ' if new_resource.force
      @cmd += '--notest ' unless new_resource.test
      @cmd += new_resource.name
      @cmd += parsed_version
      @cmd
    end

    def cpanm_uninstall_cmd
      @cmd = ''
      @cmd = "#{node['perl']['cpanm']['path']} "
      @cmd += '--force ' if new_resource.force
      @cmd += '--uninstall '
      @cmd += new_resource.name
      @cmd
    end

    # a bit of a stub, could use a version parser for really consistent expeirence
    def parsed_version
      return "~\"#{new_resource.version}\"" if new_resource.version
      ''
    end

    def current_working_dir
      return new_resource.cwd if new_resource.cwd
      return '/var/root' if node['platform'] == 'mac_os_x'
      '/root'
    end
  end
end

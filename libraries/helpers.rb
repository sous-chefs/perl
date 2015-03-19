module PerlCookbook
  # A set of helpers to use in the perl cookbook
  module Helpers
    include Chef::DSL::IncludeRecipe

    def module_exists_new_enough # rubocop:disable Metrics/AbcSize
      mod_ver = `perl -M#{new_resource.name} -e 'print $#{new_resource.name}::VERSION;' 2> /dev/null`
      return false if mod_ver.empty? # mod doesn't exist
      return true if new_resource.version.nil? # mod exists and version is unimportant
      @comparator, @pending_version = new_resource.version.split(' ', 2)
      @current_vers = Gem::Version.new(mod_ver)
      @pending_vers = Gem::Version.new(@pending_version)
      (@current_vers.method(@comparator)).call(@pending_vers)
    end

    def module_exists
      "perl -m#{new_resource.name} -e ';' 2> /dev/null"
    end

    def cpanm_install_cmd
      @cmd = "#{node['perl']['cpanm']['path']} --quiet"
      @cmd += '--force ' if new_resource.force
      @cmd += '--notest ' unless new_resource.test
      @cmd += new_resource.name
      @cmd += parsed_version
      @cmd
    end

    def cpanm_uninstall_cmd
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

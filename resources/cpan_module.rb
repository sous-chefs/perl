# frozen_string_literal: true

provides :cpan_module
unified_mode true

property :module_name, String, name_property: true
property :force, [true, false], default: false
property :test, [true, false], default: false
property :version, String
property :cwd, String
property :cpanm_path, String

action :install do
  execute "CPAN :install #{new_resource.module_name}" do
    cwd current_working_dir
    command cpanm_install_cmd
    environment 'HOME' => current_working_dir, 'PATH' => command_path
    not_if { module_exists_new_enough }
  end
end

action :uninstall do
  execute "CPAN :uninstall #{new_resource.module_name}" do
    cwd current_working_dir
    command cpanm_uninstall_cmd
    only_if { module_exists? }
  end
end

action_class do
  include ::PerlCookbook::Cookbook::Helpers

  def module_exists_new_enough
    existing_version = parse_cpan_version
    return false if existing_version.empty? # mod doesn't exist
    return true if new_resource.version.nil? # mod exists and version is unimportant

    comparator, pending_version = version_comparison
    current_version = Gem::Version.new(existing_version)
    requested_version = Gem::Version.new(pending_version)
    current_version.method(comparator).call(requested_version)
  end

  def parse_cpan_version
    mod_ver_cmd = Mixlib::ShellOut.new("perl -M#{new_resource.module_name} -e 'print $#{new_resource.module_name}::VERSION;' 2> /dev/null")
    mod_ver_cmd.run_command
    mod_ver = mod_ver_cmd.stdout
    return mod_ver if mod_ver.empty?
    # remove leading v and convert underscores to dots since gems parses them wrong
    mod_ver.gsub!(/v_?(\d)/, '\\1')
    mod_ver.tr!('_', '.')
    # in the event that this command outputs whatever it feels like, only keep the first vers number!
    version_match = /(^[0-9.]*)/.match(mod_ver)
    version_match.first
  end

  def module_exists?
    mod_check_cmd = Mixlib::ShellOut.new('perl', '-M', new_resource.module_name, '-e', '1')
    mod_check_cmd.run_command
    !mod_check_cmd.error?
  end

  def cpanm_install_cmd
    cmd = "#{resolved_cpanm_path} --quiet "
    cmd += '--force ' if new_resource.force
    cmd += '--notest ' unless new_resource.test
    cmd += new_resource.module_name
    cmd += parsed_version
    cmd
  end

  def cpanm_uninstall_cmd
    cmd = "#{resolved_cpanm_path} "
    cmd += '--force ' if new_resource.force
    cmd += '--uninstall '
    cmd += new_resource.module_name
    cmd
  end

  # a bit of a stub, could use a version parser for really consistent experience
  def parsed_version
    return "~\"#{new_resource.version}\"" if new_resource.version
    ''
  end

  def command_path
    return 'C:\\strawberry\\perl\\bin' if platform?('windows')
    '/usr/local/bin:/usr/bin:/bin'
  end

  def current_working_dir
    return new_resource.cwd if new_resource.cwd
    return '/var/root' if platform?('mac_os_x')
    return 'C:\\' if platform?('windows')
    '/root'
  end

  def version_comparison
    comparator, pending_version = new_resource.version.split(' ', 2)
    return ['>=', comparator] if pending_version.nil?

    [comparator, pending_version]
  end

  def resolved_cpanm_path
    new_resource.cpanm_path || default_cpanm_path
  end
end

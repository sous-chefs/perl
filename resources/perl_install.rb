# frozen_string_literal: true

provides :perl_install
unified_mode true

property :install_name, String, name_property: true
property :packages, [Array, String]
property :cpanm_path, String
property :cpanm_url, String, default: 'https://raw.githubusercontent.com/miyagawa/cpanminus/1.7043/cpanm'
property :cpanm_checksum, String, default: 'd2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539'
property :suppress_cpanm_diff, [true, false], default: false
property :strawberry_package, String, default: 'strawberryperl'
property :windows_perl_bin_path, String, default: 'C:\\Strawberry\\perl\\bin'

default_action :install

action :install do
  if platform?('windows')
    chocolatey_package new_resource.strawberry_package

    windows_path new_resource.windows_perl_bin_path do
      action :add
    end
  else
    resolved_perl_packages.each do |perl_package|
      package perl_package
    end

    directory ::File.dirname(resolved_cpanm_path) do
      recursive true
    end

    remote_file resolved_cpanm_path do
      source new_resource.cpanm_url
      checksum new_resource.cpanm_checksum
      owner 'root'
      group node['root_group']
      mode '0755'
      sensitive new_resource.suppress_cpanm_diff
    end
  end
end

action :remove do
  if platform?('windows')
    windows_path new_resource.windows_perl_bin_path do
      action :remove
    end

    chocolatey_package new_resource.strawberry_package do
      action :remove
    end
  else
    file resolved_cpanm_path do
      action :delete
    end

    resolved_perl_packages.each do |perl_package|
      package perl_package do
        action :remove
      end
    end
  end
end

action_class do
  include ::PerlCookbook::Cookbook::Helpers

  def resolved_perl_packages
    Array(new_resource.packages || default_perl_packages)
  end

  def resolved_cpanm_path
    new_resource.cpanm_path || default_cpanm_path
  end
end

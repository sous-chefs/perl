require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class CpanModule < Chef::Resource::LWRPBase
      self.resource_name = :cpan_module
      actions :create, :delete
      default_action :create

      attribute :module, kind_of: String, name_attribute: true
      attribute :force, kind_of: [TrueClass, FalseClass], default: false
      attribute :test, kind_of: [TrueClass, FalseClass], default: false
      attribute :cwd, kind_of: String, default: nil
    end
  end
end

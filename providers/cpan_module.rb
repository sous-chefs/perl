def whyrun_supported?
  true
end

def action_install
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already installed - nothing to do."
  else
     converge_by("Install #{ @new_resource }") do
       install_cpan_module
     end
  end
end    


def load_current_resource
  @current_resource = Chef::Resource::PerlCpanModule.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource
  
  if cpan_module_exists?(@current_resource.name)
    @current_resource.exists = true
  end
end 

def install_cpan_module
  module_name = new_resource.name
  
  bash "install_cpanmin" do
    code <<-EOH
      curl -L http://cpanmin.us | perl - App::cpanminus
    EOH
  not_if { ::File.exists?("/root/.cpanm") }
  end  

  bash "install_cpan_module" do
    code <<-EOH
      cpanm -i '#{module_name}'
    EOH
  end
end

def cpan_module_exists?(name)
  module_name = new_resource.name
  Chef::Log.debug "Checking to see if this cpan module exists #{module_name}"
  cmdStatus = system( "perl -m#{module_name} -e ''" )
  return cmdStatus
end

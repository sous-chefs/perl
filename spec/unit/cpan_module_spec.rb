require 'spec_helper'

describe 'perl_test::default' do
  context 'on Ubuntu 16.04' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'cpan_module')
                            .converge(described_recipe)
    end

    before do
      stubs_for_provider('perl_cpan_module[Uninstall test module]') do |provider|
        allow(provider).to receive_shell_out('perl', '-M', 'Test::MockModule', '-e', '1')
      end
    end

    it 'expects cpan resource to run with install action' do
      expect(chef_run).to install_cpan_module('Install test module')
    end

    it 'installs Test::MockModule via CPAN' do
      expect(chef_run).to run_execute('CPAN :install Test::MockModule')
    end

    it 'expects cpan resource to run with uninstall action' do
      expect(chef_run).to uninstall_cpan_module('Uninstall test module')
    end

    it 'uninstalls Test::MockModule via CPAN' do
      expect(chef_run).to run_execute('CPAN :uninstall Test::MockModule')
    end
  end
end

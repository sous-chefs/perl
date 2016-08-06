require 'spec_helper'

describe 'perl_test::default' do
  context 'on Ubuntu 16.04' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(step_into: 'cpan_module')
                            .converge(described_recipe)
    end

    it 'expects cpan LWRP to run with install action' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(false)
      expect(chef_run).to install_cpan_module('Test::MockModule')
    end

    it 'installs Test::MockModule via CPAN' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(false)
      expect(chef_run).to run_execute('CPAN :install Test::MockModule')
    end

    it 'expects cpan LWRP to run with uninstall action' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(true)
      expect(chef_run).to uninstall_cpan_module('Test::MockModule')
    end

    it 'installs Test::MockModule via CPAN' do
      stub_command("perl -mTest::MockModule -e ';' 2> /dev/null").and_return(true)
      expect(chef_run).to run_execute('CPAN :uninstall Test::MockModule')
    end
  end
end

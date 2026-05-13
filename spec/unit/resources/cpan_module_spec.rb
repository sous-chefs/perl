# frozen_string_literal: true

require 'spec_helper'

describe 'cpan_module' do
  step_into :cpan_module
  platform 'ubuntu', '24.04'

  before do
    shellout = instance_double(Mixlib::ShellOut, run_command: nil, stdout: '', error?: false)

    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
  end

  context 'with install action' do
    recipe do
      cpan_module 'Test::MockModule'
    end

    it { is_expected.to install_cpan_module('Test::MockModule') }

    it do
      is_expected.to run_execute('CPAN :install Test::MockModule').with(
        cwd: '/root',
        command: '/usr/local/bin/cpanm --quiet --notest Test::MockModule',
        environment: { 'HOME' => '/root', 'PATH' => '/usr/local/bin:/usr/bin:/bin' }
      )
    end
  end

  context 'with custom properties' do
    recipe do
      cpan_module 'Test::MockModule' do
        cpanm_path '/opt/cpanm'
        cwd '/tmp'
        force true
        test true
        version '>= 1.01'
      end
    end

    it do
      is_expected.to run_execute('CPAN :install Test::MockModule').with(
        cwd: '/tmp',
        command: '/opt/cpanm --quiet --force Test::MockModule~">= 1.01"'
      )
    end
  end

  context 'with uninstall action' do
    recipe do
      cpan_module 'Test::MockModule' do
        action :uninstall
      end
    end

    it { is_expected.to uninstall_cpan_module('Test::MockModule') }

    it do
      is_expected.to run_execute('CPAN :uninstall Test::MockModule').with(
        cwd: '/root',
        command: '/usr/local/bin/cpanm --uninstall Test::MockModule'
      )
    end
  end
end

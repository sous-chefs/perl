# frozen_string_literal: true

require 'spec_helper'

describe 'perl_install' do
  step_into :perl_install

  context 'on Ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      perl_install 'default'
    end

    it { is_expected.to install_perl_install('default') }
    it { is_expected.to install_package('perl') }
    it { is_expected.to install_package('libperl-dev') }
    it { is_expected.to create_directory('/usr/local/bin') }

    it do
      is_expected.to create_remote_file('/usr/local/bin/cpanm').with(
        source: 'https://raw.githubusercontent.com/miyagawa/cpanminus/1.7043/cpanm',
        checksum: 'd2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539',
        owner: 'root',
        group: 'root',
        mode: '0755',
        sensitive: false
      )
    end
  end

  context 'with custom Linux properties' do
    platform 'ubuntu', '24.04'

    recipe do
      perl_install 'custom' do
        packages %w(perl-base)
        cpanm_path '/opt/bin/cpanm'
        cpanm_url 'https://example.test/cpanm'
        cpanm_checksum 'abc123'
        suppress_cpanm_diff true
      end
    end

    it { is_expected.to install_package('perl-base') }
    it { is_expected.to create_directory('/opt/bin') }

    it do
      is_expected.to create_remote_file('/opt/bin/cpanm').with(
        source: 'https://example.test/cpanm',
        checksum: 'abc123',
        sensitive: true
      )
    end
  end

  context 'with remove action' do
    platform 'ubuntu', '24.04'

    recipe do
      perl_install 'default' do
        action :remove
      end
    end

    it { is_expected.to remove_perl_install('default') }
    it { is_expected.to delete_file('/usr/local/bin/cpanm') }
    it { is_expected.to remove_package('perl') }
    it { is_expected.to remove_package('libperl-dev') }
  end

  context 'on Windows' do
    platform 'windows', '2022'

    recipe do
      perl_install 'default'
    end

    it { is_expected.to install_chocolatey_package('strawberryperl') }

    it do
      is_expected.to add_windows_path('C:\\Strawberry\\perl\\bin')
    end
  end
end

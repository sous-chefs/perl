# frozen_string_literal: true

control 'perl-install-01' do
  impact 1.0
  title 'Perl is installed'

  describe command('perl -v') do
    its('exit_status') { should eq 0 }
  end
end

control 'perl-cpanm-01' do
  impact 1.0
  title 'cpanm is installed'

  describe file('/usr/local/bin/cpanm') do
    it { should exist }
    it { should be_executable }
  end
end

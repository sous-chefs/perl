# frozen_string_literal: true

cookbook_file '/tmp/cpanm-fixture' do
  source 'cpanm'
  mode '0755'
end

perl_install 'default' do
  packages %w(perl)
  cpanm_url 'file:///tmp/cpanm-fixture'
  cpanm_checksum 'e857960e8fa72c5528e4a794fe9d84f6af83612fda556d4f9f0384e86bb98130'
end

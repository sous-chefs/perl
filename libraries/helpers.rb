# frozen_string_literal: true

module PerlCookbook
  module Cookbook
    module Helpers
      def default_perl_packages
        case node['platform_family']
        when 'rhel', 'fedora', 'amazon'
          %w(perl perl-devel perl-CPAN)
        when 'debian'
          %w(perl libperl-dev)
        when 'freebsd'
          %w(perl5)
        else
          %w(perl)
        end
      end

      def default_cpanm_path
        return 'C:\\strawberry\\perl\\bin\\cpanm' if platform_family?('windows')

        '/usr/local/bin/cpanm'
      end
    end
  end
end

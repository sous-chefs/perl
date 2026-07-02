# frozen_string_literal: true

name 'perl'

run_list 'test::default'

named_run_list :default, 'test::default'

cookbook 'perl', path: '.'
cookbook 'test', path: './test/cookbooks/test'

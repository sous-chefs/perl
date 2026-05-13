# Migrating to Custom Resources

This release removes the legacy `perl::default` recipe and `node['perl']` attributes. Use custom
resources directly in your wrapper cookbooks.

## Recipe Migration

Replace:

```ruby
include_recipe 'perl::default'
```

with:

```ruby
perl_install 'default'
```

## Attribute Migration

Replace node attributes with resource properties:

```ruby
perl_install 'default' do
  packages %w(perl libperl-dev)
  cpanm_path '/usr/local/bin/cpanm'
  cpanm_url 'https://raw.githubusercontent.com/miyagawa/cpanminus/1.7043/cpanm'
  cpanm_checksum 'd2221f1adb956591fa43cd61d0846b961be1fffa222210f097bfd472a11e0539'
  suppress_cpanm_diff false
end
```

The `cpan_module` resource now accepts `cpanm_path` directly instead of reading
`node['perl']['cpanm']['path']`.

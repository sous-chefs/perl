# cpan_module

Installs or uninstalls CPAN modules with cpanminus.

## Actions

| Action       | Description                               |
| ------------ | ----------------------------------------- |
| `:install`   | Installs the CPAN module. Default action. |
| `:uninstall` | Uninstalls the CPAN module.               |

## Properties

| Property      | Type        | Default                      | Description                                                                  |
| ------------- | ----------- | ---------------------------- | ---------------------------------------------------------------------------- |
| `module_name` | String      | name property                | CPAN module name.                                                            |
| `force`       | true, false | `false`                      | Passes `--force` to cpanminus.                                               |
| `test`        | true, false | `false`                      | Runs module tests during install when true; otherwise passes `--notest`.     |
| `version`     | String      | `nil`                        | Version expression passed to cpanminus. Plain versions are minimum versions. |
| `cwd`         | String      | platform-specific            | Working directory for cpanminus.                                             |
| `cpanm_path`  | String      | platform-specific when unset | Path to the cpanminus executable.                                            |

## Examples

### Install a module

```ruby
cpan_module 'App::Munchies'
```

### Install a specific version range

```ruby
cpan_module 'App::Munchies' do
  version '>= 1.01, < 2.0'
end
```

### Use a custom cpanminus path

```ruby
cpan_module 'App::Munchies' do
  cpanm_path '/opt/bin/cpanm'
end
```

### Uninstall a module

```ruby
cpan_module 'App::Munchies' do
  action :uninstall
end
```

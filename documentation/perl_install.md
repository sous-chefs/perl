# perl_install

Installs or removes Perl and cpanminus.

## Actions

| Action     | Description                                             |
| ---------- | ------------------------------------------------------- |
| `:install` | Installs Perl and cpanminus. Default action.            |
| `:remove`  | Removes cpanminus and the configured Perl packages.     |

## Properties

| Property                | Type          | Default                      | Description                                                         |
| ----------------------- | ------------- | ---------------------------- | ------------------------------------------------------------------- |
| `install_name`          | String        | name property                | Resource name.                                                      |
| `packages`              | Array, String | platform-specific when unset | Perl package names to install on non-Windows platforms.             |
| `cpanm_path`            | String        | platform-specific when unset | Path where `cpanm` is installed or expected.                        |
| `cpanm_url`             | String        | upstream cpanminus URL       | Source URL for the `cpanm` script on non-Windows platforms.         |
| `cpanm_checksum`        | String        | upstream checksum            | Checksum for the `cpanm` script.                                    |
| `suppress_cpanm_diff`   | true, false   | `false`                      | Suppresses sensitive diff output for the downloaded `cpanm` script. |
| `strawberry_package`    | String        | `strawberryperl`             | Chocolatey package used on Windows.                                 |
| `windows_perl_bin_path` | String        | `C:\Strawberry\perl\bin`     | Windows Perl binary path added to `PATH`.                           |

## Examples

### Default install

```ruby
perl_install 'default'
```

### Custom cpanminus path

```ruby
perl_install 'default' do
  cpanm_path '/opt/bin/cpanm'
end
```

### Remove Perl artifacts

```ruby
perl_install 'default' do
  action :remove
end
```

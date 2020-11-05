# perl Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/perl.svg)](https://supermarket.chef.io/cookbooks/perl)
[![CI State](https://github.com/sous-chefs/perl/workflows/ci/badge.svg)](https://github.com/sous-chefs/perl/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Manages Perl installation and provides `cpan_module`, to install modules from... CPAN.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- Debian/Ubuntu/Mint
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- openSUSE
- Windows

### Chef

- Chef 13.4+

### Cookbooks

- none

## Recipes

- `default` - On Linux installs perl packages and pulls cpanm from Github. On Windows installs the Strawberry Perl Chocolatey package. Requires Chocolatey to be installed prior to running this cookbook, which can be done with the [chocolatey cookbook](https://supermarket.chef.io/cookbooks/chocolatey) from the Supermarket.

## Attributes

The cookbook ships with a sane set of platform specific attributes for installing perl as well as cpanm. There _should_ be no need to modify these attributes to use this cookbook.

- `node['perl']['packages']` - platform specific packages installed by default recipe
- `node['perl']['cpanm']['path']` - platform specific path for `cpanm` binary to live
- `node['perl']['cpanm']['url']` - URL to download cpanm script from (*nix only)
- `node['perl']['cpanm']['checksum']` - checksum for the above remote file (*nix only)
- `node['perl']['version']` - version of perl to install. (windows only)
- `node['perl']['cpanm']['path']` - The path to the cpanm binary. On *nix systems this is where the file will be installed. On Windows it's part of Strawberry Perl so no additional installation is required.
- `node['perl']['cpanm']['suppress_diff']` - Whether or not to suppress the diff of the cpanm file.

## Resources

### cpan_module

#### Actions

- `:install` - install the module (default action)
- `:uninstall` - uninstall the module

#### Properties

- `module_name` - The name of the module if it's different than the name of the resource property
- `force` - To force the install within cpanm (default: false)
- `test` - To do a test install (default: false)
- `version` - Any version string cpanm would find acceptable
- `cwd` - A path to change into before running cpanm

#### Examples

To install a module from CPAN:

```ruby
cpan_module 'App::Munchies'
```

Optionally, installation can forced with the 'force' parameter.

```ruby
cpan_module 'App::Munchies'
  force true
end
```

You can also use [cpanm's version mechanism](http://search.cpan.org/~miyagawa/App-cpanminus-1.7027/bin/cpanm#COMMANDS) to grab a specific version, or glob a version.

Exactly version 1.01 of `App::Munchies` will be installed:

```ruby
cpan_module 'App::Munchies'
  version '== 1.01'
end
```

At least version 1.01 of `App::Munchies` will be installed:

```ruby
cpan_module 'App::Munchies'
  version '1.01'
end
```

At least version 1.01 will be installed, but not version 2:

```ruby
cpan_module 'App::Munchies'
  version '>= 1.01, < 2.0'
end
```

Additionally, you can use the `cpan_module` LWRP to delete a given package (uses cpanm's `--uninstall` param)

```ruby
cpan_module 'App::Munchies'
  action :uninstall
end
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)

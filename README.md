# perl Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/perl.svg?branch=master)](http://travis-ci.org/chef-cookbooks/perl) [![Cookbook Version](https://img.shields.io/cookbook/v/perl.svg)](https://supermarket.chef.io/cookbooks/perl)

Manages Perl installation and provides `cpan_module`, to install modules from... CPAN.

## Requirements

### Platforms

- Debian/Ubuntu/Mint
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- openSUSE
- Windows

### Chef

- Chef 12.7+

### Cookbooks

- windows

## Attributes

- perl['packages'] - platform specific packages installed by default recipe
- perl['cpanm']['path'] - platform specific path for `cpanm` binary to live
- perl['cpanm']['url'] - URL to download cpanm script from
- perl['cpanm']['checksum'] - checksum for the above remote file

## Usage

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

## Maintainers

This cookbook is maintained by Chef's Community Cookbook Engineering team. Our goal is to improve cookbook quality and to aid the community in contributing to cookbooks. To learn more about our team, process, and design goals see our [team documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/COOKBOOK_TEAM.MD). To learn more about contributing to cookbooks like this see our [contributing documentation](https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/CONTRIBUTING.MD), or if you have general questions about this cookbook come chat with us in #cookbok-engineering on the [Chef Community Slack](http://community-slack.chef.io/)

## License

**Copyright:** 2009-2017, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

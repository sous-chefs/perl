perl Cookbook CHANGELOG
=======================
This file is used to list changes made in each version of the perl cookbook.

v2.0.0 (2015-09-24)
-------------------
- Rewrote cpan_module definition as a LWRP with Chefspec tests and matchers
- Add the ability to select version in the cpan_module LWRP
- Fixed cpan_module incompatibility with Chef 12
- Fixed download location for cpanm to prevent failures on the redirect
- Removed Chef 10 compatibility.  This cookbook now requires 11+
- Added libwww-perl installation on Debian systems
- Added support for RHEL/CentOS 7 and Fedora to the default.rb recipe
- Added source_url and issues_url metadata
- Added a chefignore file to limit files uploaded to the server
- Updated Contributing and Testing docs
- Added a rakefile for simplified testing
- Added maintainers.md and maintainers.toml file and a Rake task for generating MD from TOML
- Updated platforms tested in Kitchen CI and update the Kitchen config format
- Updated to the standard chef .rubocop.yml file
- Updated all testing and development gems to the latest
- Add basic Chefspec test
- Updated Travis CI to test on modern ruby versions and reenabled rspec and foodcritic testing
- Added cookbook version and Travis CI badges to the readme
- Added a .foodcritic file to skip FC015
- Removed all references to Opscode
- Remove the Gemfile.lock that shouldn't have been committed

v1.2.4 (2014-06-16)
-------------------
- [COOK-4725] Use windows_path to set the PATH

v1.2.2
------
### New Feature
- **[COOK-4013](https://tickets.chef.io/browse/COOK-4013)** - add omnios support to perl cookbook

v1.2.0
------
### Improvement
- **[COOK-3230](https://tickets.chef.io/browse/COOK-3230)** - Upgrade cpanm
- **[COOK-2998](https://tickets.chef.io/browse/COOK-2998)** - Improve install speed by using `--notest`

v1.1.2
------
### Bug
- [COOK-2973]: perl cookbook has foodcritic errors

v1.1.0
------
- [COOK-1765] - Install Strawberry Perl on Windows in Perl Cookbook

v1.0.2
------
- [COOK-1300] - add support for Mac OS X

v1.0.0
------
- [COOK-1129] - move lists of perl packages to attributes by platform
- [COOK-1279] - resolve regression from COOK-1129
- [COOK-1299] - use App::cpanminus (cpanm) to install "cpan packages"

v0.10.2
------
- [COOK-1279] Re-factor recipe and fix platform_version 5 bug for redhat family platforms

v0.10.1
------
- [COOK-1129] centos/redhat needs the CPAN RPM installed

v0.10.0
------
- Current released version

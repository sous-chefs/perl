# AGENTS.md

## Cookbook Scope

The `perl` cookbook installs Perl from operating system package repositories on Linux and uses
Strawberry Perl on Windows. Tested support is limited to the platforms declared in `metadata.rb`
and Kitchen.

## Package Availability

* Debian 12 and 13 include Perl packages in the default repositories.
* Ubuntu 22.04 and 24.04 include Perl packages in the default repositories.
* AlmaLinux, CentOS Stream, Oracle Linux, Red Hat, and Rocky Linux provide Perl packages through
  their base repositories.
* Amazon Linux 2023 is retained; Amazon Linux 2 is no longer used for CI because it reaches end of
  support on June 30, 2026.
* openSUSE Leap 15.x is not retained because Leap 15.6 reached end-of-life on April 30, 2026.
  Leap 16.x should be added once a supported Dokken image is available.
* Windows installs use the Strawberry Perl Chocolatey package. Chocolatey must be available before
  the `perl_install` resource runs.

## Implementation Notes

* The cookbook does not select architecture-specific Perl builds. Package architecture availability
  is delegated to the target operating system package manager or Chocolatey package source.
* The cookbook does not compile Perl from source.
* Dependency resolution is Policyfile-first. Do not reintroduce `Berksfile` or `berks install`.
* `test` is a local fixture cookbook and must remain a path dependency in `Policyfile.rb`.

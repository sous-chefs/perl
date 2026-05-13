# Limitations

## Package Availability

This cookbook installs Perl from operating system package repositories on Linux and uses
Strawberry Perl on Windows. Perl itself runs on more than 100 platforms, but this cookbook's tested
surface is limited to the platforms declared in `metadata.rb` and Kitchen.

### APT (Debian/Ubuntu)

* Debian 12 and 13 include Perl packages in the default repositories.
* Ubuntu 22.04 and 24.04 include Perl packages in the default repositories.
* Debian 10, Debian 11, Ubuntu 18.04, and Ubuntu 20.04 are not retained in Kitchen because their
  normal security support has ended or no longer matches current sous-chefs test policy.

### DNF/YUM (RHEL family)

* AlmaLinux, CentOS Stream, Oracle Linux, Red Hat, and Rocky Linux provide Perl packages through
  their base repositories.
* CentOS Linux 7 and CentOS Stream 8 are removed because they are end-of-life.
* Amazon Linux 2023 is retained; Amazon Linux 2 is no longer used for CI because it reaches end of
  support on June 30, 2026.

### Zypper (SUSE)

* openSUSE Leap 15.x is removed from Kitchen because Leap 15.6 reached end-of-life on April 30,
  2026. Leap 16.x should be added once a supported Dokken image is available.

### Windows

* Windows installs use the Strawberry Perl Chocolatey package. Chocolatey must be available before
  the `perl_install` resource runs.

## Architecture Limitations

The cookbook does not select architecture-specific Perl builds. Package architecture availability
is delegated to the target operating system package manager or Chocolatey package source.

## Source/Compiled Installation

The cookbook does not compile Perl from source. CPAN documents source installation using
`Configure`, `make`, `make test`, and `make install` for users who need a custom source build.

## Sources Checked

* [Perl downloads](https://www.perl.org/get.html)
* [Perl source releases](https://www.cpan.org/src/)
* [cpanminus upstream](https://github.com/miyagawa/cpanminus)
* Platform lifecycles: [Ubuntu](https://endoflife.date/ubuntu),
  [Debian](https://endoflife.date/debian),
  [Amazon Linux](https://endoflife.date/amazon-linux),
  [CentOS](https://endoflife.date/centos),
  [CentOS Stream](https://endoflife.date/centos-stream),
  [RHEL](https://endoflife.date/rhel),
  [AlmaLinux](https://endoflife.date/almalinux),
  [Rocky Linux](https://endoflife.date/rocky-linux),
  [Oracle Linux](https://endoflife.date/oracle-linux),
  [openSUSE](https://endoflife.date/opensuse)

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
### Added
- Added rspec-puppet catalog tests of the `aem_helloworld` classes, run by `make test`
- Added acceptance tests with voxpupuli-acceptance (Beaker on Docker), which run `pre-common.sh` and `post-common.sh` from the package as Packer AEM does on Amazon Linux 2023 and Rocky Linux 10 stand-ins for the AEM AMIs, run by `make acceptance`
- Added Puppet manifest validation, yamllint and markdownlint to the lint target

### Changed
- Upgraded to Ruby 4.0.7 and OpenVox 9 with Vox Pupuli tooling, replacing puppet-lint 2.3.6 and RuboCop 0.69.0
- Changed the manifests to read the `component` and `custom_stage_run_info` facts from `$facts`, as OpenVox 9 enables strict_variables
- Changed the steps to run the `inspec` command of Cinc InSpec, which the AMIs must provide, instead of `/opt/puppetlabs/puppet/bin/inspec`
- Changed the InSpec tests to read the component fact with the facter command, as Cinc InSpec 7 can't load the facter gem
- Disabled the file_ensure puppet-lint checks of the Vox Pupuli plugins, as their fixes would change what the manifests do
- Changed the target platforms to Amazon Linux 2023 and Rocky Linux 10
- Upgraded GitHub CI to actions/checkout v7
- Simplify CI workflow to not use action files anymore
- Upgrade aem-platform-buildenv to 6.4.1
- Upgrade release workflows to cliffano/release-action 2.1.0
- Committed Gemfile.lock and kept it on make clean, so CI installs the pinned gems

## 0.10.0 - 2021-10-04
### Added
- Add release-major, release-minor, release-patch, and publish Makefile targets and GitHub Actions

## 0.9.1 - 2019-05-15
### Changed
- Update tests with latest Rubocop

## 0.9.0 - 2018-07-31
### Added
- Initial version

# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

# The acceptance tests run the package as packer-aem's config::custom_image_provisioner does, without AEM:
# the nodeset is the AMI being built (see its comments), the package from `make package` is unpacked into
# INSTALL_DIR, and the facts packer-aem sets are passed as FACTER_* environment variables.

# The nodesets bake OpenVox 9 in, as the AMIs do, so configure_beaker doesn't install an agent
ENV['BEAKER_PUPPET_COLLECTION'] ||= 'preinstalled'

INSTALL_DIR = '/opt/shinesolutions/aem-custom-image-provisioner'

# The package `make package` built
def provisioner_package
  Dir.glob('stage/aem-helloworld-custom-image-provisioner-*.tar.gz').max_by { |path| File.mtime(path) } ||
    raise('No package in stage/, run make package first')
end

def install_provisioner(host)
  scp_to(host, provisioner_package, '/tmp/aem-custom-image-provisioner.tar.gz')
  on(host, "mkdir -p #{INSTALL_DIR} && tar -xzf /tmp/aem-custom-image-provisioner.tar.gz -C #{INSTALL_DIR} " \
           '&& rm /tmp/aem-custom-image-provisioner.tar.gz')
end

# Runs a step's script with the given facts, as packer-aem does
def run_step(step, facts)
  environment = facts.map { |name, value| "FACTER_#{name}='#{value}'" }.join(' ')
  on(default, "#{environment} #{INSTALL_DIR}/#{step}-common.sh")
end

configure_beaker(modules: nil) do |host|
  install_provisioner(host)
end

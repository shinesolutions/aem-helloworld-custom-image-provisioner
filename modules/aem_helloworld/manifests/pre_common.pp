# The component and custom_stage_run_info facts are read from $facts, as OpenVox 9 enables strict_variables,
# under which an unset top-scope variable ($::custom_stage_run_info when CUSTOM_STAGE_RUN_INFO isn't given) fails the run
class aem_helloworld::pre_common (
) {
  notify { 'Display status message with component name':
    message => "Executing Custom Image Provisioner pre-common step for component '${facts['component']}' having run info '${facts['custom_stage_run_info']}'",
  }

  file { '/opt/aem-helloworld-custom-image-provisioner/':
    ensure => directory,
    mode   => '0775',
  }

  file { "/opt/aem-helloworld-custom-image-provisioner/${facts['component']}-pre.txt":
    ensure => present,
    mode   => '0664',
  }
}

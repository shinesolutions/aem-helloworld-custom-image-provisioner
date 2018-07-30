class aem_helloworld::pre_common (
) {

  notify { 'Display status message with component name':
    message => "Executing Custom Image Provisioner pre-common step for component '${::component}' having run info '${::custom_stage_run_info}'",
  }

  file { '/opt/aem-helloworld-custom-image-provisioner/':
    ensure => directory,
    mode   => '0775',
  }

  file { "/opt/aem-helloworld-custom-image-provisioner/${::component}-pre.txt":
    ensure => present,
    mode   => '0664',
  }

}

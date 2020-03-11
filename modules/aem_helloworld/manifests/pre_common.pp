class aem_helloworld::pre_common (
  $duration_time = 900, # 15mins
  $session_name = "AssumeRoleSession",
  $region_name = 'ap-southeast-2',
  $assume_policy = ["route53:*"],
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

  aws_assume_role($duration_time, $session_name, $region_name, $assume_policy)
}

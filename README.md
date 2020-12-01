[![Build Status](https://github.com/shinesolutions/aem-helloworld-custom-image-provisioner/workflows/CI/badge.svg)](https://github.com/shinesolutions/aem-helloworld-custom-image-provisioner/actions?query=workflow%3ACI)
[![Known Vulnerabilities](https://snyk.io/test/github/shinesolutions/aem-helloworld-custom-image-provisioner/badge.svg)](https://snyk.io/test/github/shinesolutions/aem-helloworld-custom-image-provisioner)

# AEM Hello World Custom Image Provisioner

This is an example AEM Hello World Custom Image Provisioner artifact that will be set up as one of [Packer AEM customisation points](https://github.com/shinesolutions/packer-aem/blob/master/docs/customisation-points.md#custom-image-provisioner).

This artifact contains:
* `pre-common.sh` shell script which will be executed before component image provisioning
* `post-common.sh` shell script which will be executed after component image provisioning
* Example [Puppet module](https://puppet.com/docs/puppet/5.3/modules_fundamentals.html) manifests in `modules/aem_helloworld` directory
* Example [InSpec tests](https://www.inspec.io/) which will check the result of the above Puppet module, the binary is available at `/opt/puppetlabs/puppet/bin/inspec`

Here's an example log output of the post step:

<img src="https://raw.githubusercontent.com/shinesolutions/aem-helloworld-custom-image-provisioner/master/docs/post-step-log.png" width="800"/>

The use of Puppet and InSpec here is just an example. You can use other tools like Ansible, or even plain shell script if need be. They can be installed either in the pre-common.sh/post-common.sh shell scripts or in [Packer AEM source image](https://github.com/shinesolutions/packer-aem/blob/master/docs/customisation-points.md#source-image).

## Usage

To create artifact tar.gz file:

    make package

The artifact will be written at `stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz`

Copy the tar.gz artifact file to Packer AEM, please note that the file must be (re)named to `aem-custom-image-provisioner.tar.gz`:

    cp stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz <path/to/packer-aem>/stage/custom/aem-custom-image-provisioner.tar.gz

If you are using Puppet, the following global facts are available:

| Fact | Description |
|------|-------------|
| `::component` | The component name, useful for identifying which image is being provisioned. |
| `::custom_stage_run_info` | A user defined string for passing additional provisioning run information. User can inject this value by specifying environment variable `CUSTOM_STAGE_RUN_INFO` when executing Packer AEM build. |

If you need more information from the provisioning process, you can tap into the Hiera data by adding `-hiera_config='/tmp/packer-puppet-masterless/hiera.yaml` flag to your Puppet apply call.

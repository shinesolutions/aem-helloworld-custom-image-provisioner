[![Build Status](https://img.shields.io/travis/shinesolutions/aem-helloworld-custom-image-provisioner.svg)](http://travis-ci.org/shinesolutions/aem-helloworld-custom-image-provisioner)

# AEM Hello World Custom Image Provisioner

This is an example AEM Hello World Custom Image Provisioner artifact that will be set up in [Packer AEM](https://github.com/shinesolutions/packer-aem/blob/master/docs/customisation-points.md#custom-image-provisioner) as one of the customisation points.

This artifact contains:
* `pre-common.sh` shell script which will be executed before component image provisioning
* `post-common.sh` shell script which will be executed after component image provisioning
* Example [Puppet module](https://puppet.com/docs/puppet/5.3/modules_fundamentals.html) manifests in `modules/aem_helloworld` directory
* Example [InSpec tests](https://www.inspec.io/) which will check the result of the above Puppet module

The use of Puppet and InSpec here is just an example. You can use other tools like Ansible, or even plain shell script if need be.

Here's an example log output of the post step:

<img src="https://raw.githubusercontent.com/shinesolutions/aem-helloworld-custom-image-provisioner/master/docs/post-step-log.png" width="800"/>

## Usage

To create artifact tar.gz file:

    make package

The artifact will be written at `stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz`

Copy the tar.gz artifact file to Packer AEM, please note that the file must be (re)named to `aem-custom-image-provisioner.tar.gz`:

    cp stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz <path/to/packer-aem>/stage/custom/aem-custom-image-provisioner.tar.gz

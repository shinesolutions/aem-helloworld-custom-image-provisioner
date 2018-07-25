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



## Usage

To create artifact tar.gz file:

    make package

The artifact will be written at `stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz`

Copy the tar.gz artifact file to Packer AEM:

    cp stage/aem-helloworld-custom-image-provisioner-<version>.tar.gz <path/to/packer-aem>/stage/custom/

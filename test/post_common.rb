# frozen_string_literal: true

require 'facter'

component = Facter.value(:component)

describe file('/opt/aem-helloworld-custom-image-provisioner/') do
  it { should be_directory }
  it { should exist }
  its('mode') { should cmp '00775' }
end

describe file("/opt/aem-helloworld-custom-image-provisioner/#{component}-post.txt") do
  it { should be_file }
  it { should exist }
  its('mode') { should cmp '00664' }
end

# frozen_string_literal: true

require 'spec_helper'

describe 'aem_helloworld::post_common' do
  on_supported_os(supported_os).each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts.merge(component: 'author', custom_stage_run_info: 'some run info') }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_notify('Display status message with component name').with_message(/component 'author' having run info 'some run info'/) }
      it { is_expected.to contain_file('/opt/aem-helloworld-custom-image-provisioner/').with(ensure: 'directory', mode: '0775') }
      it { is_expected.to contain_file('/opt/aem-helloworld-custom-image-provisioner/author-post.txt').with(ensure: 'present', mode: '0664') }

      # packer-aem only sets custom_stage_run_info when CUSTOM_STAGE_RUN_INFO is given
      context 'without custom_stage_run_info' do
        let(:facts) { os_facts.merge(component: 'author') }

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end

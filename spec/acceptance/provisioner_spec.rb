# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'the custom image provisioner steps' do
  %w[pre post].each do |step|
    context "with #{step}-common.sh" do
      # The scripts exit non-zero when puppet apply or the InSpec test fails
      it 'runs the Puppet manifest and its InSpec test' do
        result = run_step(step, component: 'author', custom_stage_run_info: 'some run info')
        expect(result.stdout).to include("component 'author' having run info 'some run info'")
      end

      # packer-aem only sets custom_stage_run_info when CUSTOM_STAGE_RUN_INFO is given
      it 'runs without custom_stage_run_info' do
        expect(run_step(step, component: 'publish').exit_code).to eq(0)
      end

      describe file("/opt/aem-helloworld-custom-image-provisioner/author-#{step}.txt") do
        it { is_expected.to be_file }
        it { is_expected.to be_mode 664 }
      end
    end
  end
end

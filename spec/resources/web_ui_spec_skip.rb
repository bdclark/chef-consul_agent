require 'spec_helper'

describe 'consul_agent_web_ui' do
  let(:platform) { 'ubuntu' }
  let(:version) { '14.04' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: platform, version: version,
                             step_into: ['consul_agent_web_ui'],
                             file_cache_path: '/tmp/chef') do |node|
      node.set['consul_agent']['version'] = '0.6.4'
      node.set['consul_agent']['serve_web_ui'] = true
    end.converge('consul_agent::default')
  end

  context 'with ubuntu' do
    it 'create extract directory' do
      expect(chef_run).to create_directory('/opt/consul-webui/0.6.4').with(
        owner: 'root', group: 'root', mode: '0755')
    end

    it 'download webui' do
      expect(chef_run).to create_remote_file('/tmp/chef/consul_0.6.4_web_ui.zip').with(
        source: 'https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip',
        checksum: '5f8841b51e0e3e2eb1f1dc66a47310ae42b0448e77df14c83bb49e0e0d5fa4b7',
        owner: 'root', group: 'root')
    end

    it 'install unzip package' do
      expect(chef_run).to install_package('unzip')
    end

    it 'unzip webui' do
      expect(chef_run).to run_execute('unzip_consul_webui_0.6.4').with(
        command: 'unzip /tmp/chef/consul_0.6.4_web_ui.zip -d /opt/consul-webui/0.6.4')
    end

    it 'link webui' do
      expect(chef_run).to create_link('/opt/consul-webui/current').with(
        to: '/opt/consul-webui/0.6.4')
    end
  end
end

require 'spec_helper'

describe 'consul_agent_install' do
  let(:platform) { 'ubuntu' }
  let(:version) { '14.04' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: platform, version: version,
                             step_into: ['consul_agent_install'],
                             file_cache_path: '/tmp/chef') do |node|
      node.set['consul_agent']['version'] = '0.6.4'
    end.converge('consul_agent::default')
  end

  context 'with ubuntu' do
    it 'create extract directory' do
      expect(chef_run).to create_directory('/usr/local/bin/consul-0.6.4').with(
        owner: 'root', group: 'root', mode: '0755')
    end

    it 'download consul' do
      expect(chef_run).to create_remote_file('/tmp/chef/consul_0.6.4_linux_amd64.zip').with(
        source: 'https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip',
        checksum: 'abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627',
        owner: 'root', group: 'root')
    end

    it 'install unzip package' do
      expect(chef_run).to install_package('unzip')
    end

    it 'unzip consul' do
      expect(chef_run).to run_execute('unzip_consul_0.6.4').with(
        command: 'unzip /tmp/chef/consul_0.6.4_linux_amd64.zip -d /usr/local/bin/consul-0.6.4')
    end

    it 'link consul' do
      expect(chef_run).to create_link('/usr/local/bin/consul').with(
        to: '/usr/local/bin/consul-0.6.4/consul')
    end
  end
end

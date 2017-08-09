require 'spec_helper'

describe 'consul_agent::default' do
  let(:platform) { 'ubuntu' }
  let(:version) { '14.04' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
      node.set['consul_agent']['version'] = '0.6.4'
      node.set['consul_agent']['serve_web_ui'] = true
    end.converge(described_recipe)
  end

  context 'with an unspecified platform' do
    it 'create service group' do
      expect(chef_run).to create_group('consul').with(
        system: true
      )
    end

    it 'create service user' do
      expect(chef_run).to create_user('consul').with(
        shell: '/bin/false', group: 'consul', system: true
      )
    end

    it 'create consul_agent_install' do
      expect(chef_run).to create_consul_agent_install('0.6.4')
    end

    it 'create consul_agent_config' do
      expect(chef_run).to create_consul_agent_config('/etc/consul/config.json')
    end

    it 'enable consul_agent_service' do
      expect(chef_run).to enable_consul_agent_service('consul')
    end

    it 'start consul_agent_service' do
      expect(chef_run).to start_consul_agent_service('consul')
    end
  end
end

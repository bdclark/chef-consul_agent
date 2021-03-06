require 'spec_helper'

describe command('sleep 15') do
  its(:exit_status) { should eq 0 }
end

describe service('consul') do
  it { should be_enabled }
  it { should be_running }
end

[8300, 8400, 8500, 8600].each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command('/usr/local/bin/consul members') do
  its(:stdout) { should match('server') }
  its(:stdout) { should match('dev-use1') }
end

describe file('/etc/consul/config.json') do
  it { should be_file }
  its(:content) { should match('"acl_master_token": "supersecret"') }
  its(:content) { should match('"acl_token": "secret_agent"') }
end

describe command('curl -s http://localhost:8500/ui/') do
  its(:stdout) { should match('<title>Consul by HashiCorp</title>') }
end

describe command(%(curl -s 'http://localhost:8500/v1/catalog/service/foo?pretty')) do
  its(:stdout) { should contain '"ServiceID": "foo"' }
  its(:stdout) { should contain '"ServiceAddress": "10.20.30.40"' }
  its(:stdout) { should contain '"ServicePort": 1234' }
end

describe command(%(curl -s 'http://localhost:8500/v1/catalog/service/bar?pretty')) do
  its(:stdout) { should contain '"ServiceID": "bar"' }
  its(:stdout) { should contain '"ServiceAddress": "5.6.7.8"' }
  its(:stdout) { should contain '"ServicePort": 5678' }
end

dns_server = '127.0.0.1' if os[:family] == 'redhat' && os[:release].to_i == 6

describe command("host foo.service.consul #{dns_server}") do
  its(:stdout) { should match(/^foo.service.consul has address 10.20.30.40/) }
end

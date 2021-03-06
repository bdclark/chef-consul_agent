
node.default['consul_agent']['config']['datacenter'] = 'dev-use1'
node.default['consul_agent']['config']['server'] = true
node.default['consul_agent']['config']['bootstrap_expect'] = 1
node.default['consul_agent']['config']['acl_master_token'] = 'supersecret'
node.default['consul_agent']['config']['acl_default_policy'] = 'deny'
node.default['consul_agent']['config']['acl_datacenter'] = 'dev-use1'
node.default['consul_agent']['config']['acl_token'] = 'secret_agent'
node.default['consul_agent']['config']['ui'] = true

include_recipe 'apt'
include_recipe 'consul_agent'
include_recipe 'consul_agent::dnsmasq'

package 'curl'
package 'bind9-host' if platform_family?('debian')
package 'bind-utils' if platform_family?('rhel')

consul_agent_acl 'secret_agent' do
  rules <<-EOS
service "" {
  policy = "read"
}
  EOS
  auth_token node['consul_agent']['config']['acl_master_token']
end

consul_agent_definition 'foo' do
  type 'service'
  parameters(
    address: '10.20.30.40',
    port: 1234,
    token: 'supersecret'
  )
  notifies :reload, 'consul_agent_service[consul]', :delayed
end

consul_agent_service_definition 'bar' do
  address '5.6.7.8'
  port 5678
  token 'supersecret'
  notifies :reload, 'consul_agent_service[consul]', :delayed
end

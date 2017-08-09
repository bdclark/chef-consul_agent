#
# Cookbook Name:: consul_agent
#
# Copyright 2016 Brian Clark
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package 'dnsmasq'

dns_domain = node['consul_agent']['config']['domain'] || 'consul'

dns_ip =
  if node['consul_agent']['config'].key?('addresses') &&
     node['consul_agent']['config']['addresses']['dns']
    node['consul_agent']['config']['addresses']['dns']
  elsif node['consul_agent']['config']['client_addr'] &&
        node['consul_agent']['config']['client_addr'] != '0.0.0.0'
    node['consul_agent']['config']['client_addr']
  else
    '127.0.0.1'
  end

dns_port =
  if node['consul_agent']['config'].key?('ports') &&
     node['consul_agent']['config']['ports']['dns']
    node['consul_agent']['config']['ports']['dns']
  else
    8600
  end

if platform_family?('rhel') && node['consul_agent']['dnsmasq']['network_manager_enabled']
  file '/etc/NetworkManager/dnsmasq.d/10-consul' do
    content "server=/#{dns_domain}/#{dns_ip}##{dns_port}\n"
    owner 'root'
    group node['root_group']
    mode '0644'
    notifies :restart, 'service[NetworkManager]'
  end

  file '/etc/NetworkManager/NetworkManager.conf' do
    content <<-EOH.gsub(/^ {4}/, '')
      [main]
      plugins=ifcfg-rh
      dns=dnsmasq
    EOH
    owner 'root'
    group node['root_group']
    mode '0644'
    notifies :restart, 'service[NetworkManager]'
  end

  service 'NetworkManager' do
    action :nothing
  end

  service 'dnsmasq' do
    action [:stop, :disable]
  end
else

  ruby_block 'dnsmasq_conf-dir' do
    block do
      file = Chef::Util::FileEdit.new('/etc/dnsmasq.conf')
      file.search_file_replace_line(/^conf-dir=/, %(conf-dir=/etc/dnsmasq.d))
      file.insert_line_if_no_match(/^conf-dir=/, %(conf-dir=/etc/dnsmasq.d))
      file.write_file
      File.delete('/etc/dnsmasq.conf.old') if File.exist?('/etc/dnsmasq.conf.old')
    end
    not_if { ::File.read('/etc/dnsmasq.conf') =~ %r{^conf-dir=\/etc\/dnsmasq.d} }
    notifies :restart, 'service[dnsmasq]'
  end

  file '/etc/dnsmasq.d/10-consul' do
    content "server=/#{dns_domain}/#{dns_ip}##{dns_port}\n"
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[dnsmasq]'
  end

  template '/etc/dnsmasq_resolv.conf' do
    source 'dnsmasq_resolv.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action node['consul_agent']['dnsmasq']['upstream_servers'].empty? ? :delete : :create
    notifies :restart, 'service[dnsmasq]'
  end

  file '/etc/dnsmasq.d/20-upstream-servers' do
    content "resolv-file=/etc/dnsmasq_resolv.conf\n"
    owner 'root'
    group 'root'
    mode '0644'
    action node['consul_agent']['dnsmasq']['upstream_servers'].empty? ? :delete : :create
    notifies :restart, 'service[dnsmasq]'
  end

  service 'dnsmasq' do
    action [:enable, :start]
  end
end

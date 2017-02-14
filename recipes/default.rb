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

include_recipe 'consul_agent::service_user' if node['consul_agent']['create_service_user']

consul_agent_install node['consul_agent']['version'] do
  checksum node['consul_agent']['checksum'] if node['consul_agent']['checksum']
  if node['consul_agent']['restart_on_update']
    notifies :restart, 'consul_agent_service[consul]', :delayed
  end
end

consul_agent_config node['consul_agent']['config_path'] do
  config node['consul_agent']['config']
  notifies :reload, 'consul_agent_service[consul]', :delayed
end

consul_agent_service 'consul' do
  config_file node['consul_agent']['config_path']
  config_dir node['consul_agent']['config_dir']
  data_dir node['consul_agent']['config']['data_dir']
  restart_on_update node['consul_agent']['restart_on_update']
  action [:enable, :start]
end

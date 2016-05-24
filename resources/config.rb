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

property :path, String, name_property: true
property :user, String, default: lazy { node['consul_agent']['service_user'] }
property :group, String, default: lazy { node['consul_agent']['service_group'] }
property :config, Hash, required: true

default_action :create

action :create do
  directory ::File.dirname(new_resource.path) do
    recursive true
    owner new_resource.user
    group new_resource.group
    mode '0755'
    not_if { ::File.dirname(new_resource.path) == '/etc' }
  end

  file new_resource.path do
    owner new_resource.user
    group new_resource.group
    mode '0640'
    content JSON.pretty_generate(Hash[config.sort], quirks_mode: true)
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end

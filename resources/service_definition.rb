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

property :name, String, name_property: true
property :path, String, default: lazy { ::File.join(node['consul_agent']['config_dir'], "#{name}.json") }
property :user, String, default: lazy { node['consul_agent']['service_user'] }
property :group, String, default: lazy { node['consul_agent']['service_group'] }
property :id, String
property :tags, Array
property :address, String
property :port, Integer
property :enableTagOverride, [TrueClass, FalseClass]
property :check, Hash
property :checks, Array
property :token, String

default_action :create

action :create do
  params = { name: name }
  [:id, :tags, :address, :port, :enableTagOverride, :check, :checks, :token].each do |param|
    value = new_resource.instance_variable_get("@#{param}")
    params[param] = value unless value.nil?
  end

  content = JSON.pretty_generate(service: params)

  file new_resource.path do
    content content
    owner new_resource.user
    group new_resource.group
    mode '0640'
  end
end

action :delete do
  file new_resource.path do
    action :delete
  end
end

action_class do
  def whyrun_supported?
    true
  end
end

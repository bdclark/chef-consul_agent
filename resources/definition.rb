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
property :type, String, required: true
property :parameters, Hash, required: true

default_action :create

action :create do
  unless %w(service check services checks).include?(new_resource.type)
    raise "Unsupported definition type: #{new_resource.type}"
  end

  file new_resource.path do
    content json_content
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

action_class.class_eval do
  def json_content
    params = new_resource.parameters
    if %w(check service).include?(new_resource.type) && params[:name].nil? && params['name'].nil?
      params[:name] = name
    end
    JSON.pretty_generate(new_resource.type => params)
  end
end

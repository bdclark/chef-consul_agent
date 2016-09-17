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

property :version, String, name_property: true
property :path, String, default: lazy { node['consul_agent']['bin_dir'] }
property :url, String
property :checksum, String

default_action :create

action :create do
  bin_dir = directory ::File.join(new_resource.path, "consul-#{new_resource.version}") do
    owner 'root'
    group node['root_group']
    mode '0755'
    recursive true
  end

  zip = remote_file ::File.join(Chef::Config[:file_cache_path], zip_filename) do
    source new_resource.url || "https://releases.hashicorp.com/consul/#{new_resource.version}/#{zip_filename}"
    owner 'root'
    group node['root_group']
    checksum new_resource.checksum || checksums[zip_filename]
  end

  # TODO: make me platform-friendly
  package 'unzip'
  execute "unzip_consul_#{new_resource.version}" do
    command %(unzip #{zip.path} -d #{bin_dir.path})
    action :run
    creates ::File.join(bin_dir.path, 'consul')
  end

  link ::File.join(new_resource.path, 'consul') do
    to ::File.join(bin_dir.path, 'consul')
  end
end

action :remove do
  directory ::File.join(new_resource.path, "consul-#{version}") do
    recursive true
    action :delete
  end
end

action_class do
  def whyrun_supported?
    true
  end

  def zip_filename
    arch =
      case node['kernel']['machine']
      when 'x86_64', 'amd64' then 'amd64'
      when /i\d86/ then '386'
      else node['kernel']['machine']
      end
    "consul_#{new_resource.version}_#{node['os']}_#{arch}.zip"
  end
end

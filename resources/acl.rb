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

property :id, String, name_property: true
property :url, String, default: 'http://localhost:8500'
property :auth_token, String, required: true
property :acl_name, String, default: ''
property :type, String, default: 'client'
property :rules, String, default: ''

default_action :create

action :create do
  require_diplomat
  configure_diplomat

  unless up_to_date?
    Diplomat::Acl.create(acl)
    # updated
  end
end

action :delete do
  require_diplomat
  configure_diplomat

  unless Diplomat::Acl.info(new_resource.id).empty?
    Diplomat::Acl.destroy(new_resource.id)
    # updated
  end
end

action_class.class_eval do
  def acl
    { 'ID' => id, 'Type' => type, 'Name' => acl_name, 'Rules' => rules }
  end

  def require_diplomat
    require 'diplomat'
  rescue LoadError
    Chef::Log.debug('Did not find diplomat. Installing now')
    chef_gem 'diplomat' do
      version node['consul_agent']['diplomat_version']
      compile_time true if Chef::Resource::ChefGem.method_defined?(:compile_time)
      action :install
    end
    require 'diplomat'
  end

  def configure_diplomat
    begin
      require 'diplomat'
    rescue LoadError
      raise RunTimeError, 'The diplomat gem is required; ' \
                          'include recipe[consul_agent::client_gem] to install.'
    end
    Diplomat.configure do |config|
      config.url = new_resource.url
      config.acl_token = new_resource.auth_token
      config.options = { request: { timeout: 10 } }
    end
  end

  def up_to_date?
    old_acl = Diplomat::Acl.info(new_resource.id, nil, :return)
    return false if old_acl.nil? || old_acl.empty?
    old_acl.first.select! { |k, _v| %w(ID Type Name Rules).include?(k) }
    old_acl.first == acl
  end
end

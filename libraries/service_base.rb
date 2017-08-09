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

module ConsulAgentCookbook
  class ConsulAgentService < ChefCompat::Resource
    unless defined?(Boolean)
      Boolean = property_type(
        is: [true, false],
        default: false
      )
    end

    property :service_name, String, name_property: true
    property :program, String, default: lazy { ::File.join(node['consul_agent']['bin_dir'], 'consul') }
    property :data_dir, String, required: true
    property :config_file, String
    property :config_dir, String
    property :log_dir, String, default: lazy { node['consul_agent']['log_dir'] }
    property :user, String, default: lazy { node['consul_agent']['service_user'] }
    property :group, String, default: lazy { node['consul_agent']['service_group'] }
    property :stop_signal, String, default: lazy { node['consul_agent']['stop_signal'] }
    property :environment, Hash
    property :restart_on_update, Boolean, default: true

    default_action :create

    action :create do
      ensure_config
      create_init
    end

    action :start do
      ensure_config
      create_init
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :start
      end
    end

    action :restart do
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :restart
      end
    end

    action :reload do
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :reload
      end
    end

    action :enable do
      ensure_config
      create_init
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :enable
      end
    end

    action :stop do
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :stop
        only_if { ::File.exist?(service_file) }
      end
    end

    action :disable do
      service consul_service_name do
        supports restart: true, reload: true, status: true
        action :disable
        only_if { ::File.exist?(service_file) }
      end
    end

    declare_action_class.class_eval do
      def whyrun_supported?
        true
      end

      def ensure_config
        if new_resource.config_file.nil? && new_resource.config_dir.nil?
          raise 'config_file and/or config_dir is required'
        end
      end

      def create_directories
        directory "#{new_resource.name}-data_dir" do
          path new_resource.data_dir
          owner new_resource.user
          group new_resource.group
          mode '0755'
          recursive true
        end

        directory "#{new_resource.name}-config_dir" do
          path new_resource.config_dir
          owner 'root'
          group 'root'
          mode '0755'
          recursive true
          not_if { new_resource.config_dir.nil? }
        end
      end

      def consul_service_name
        service_name == 'consul' ? 'consul' : "consul-#{service_name}"
      end

      def daemon_options
        opts = 'agent'
        opts << " -config-file=#{config_file}" if config_file
        opts << " -config-dir=#{config_dir}" if config_dir
      end

      def default_environment
        {
          'GOMAXPROCS' => [node['cpu']['total'], 2].max.to_s,
          'PATH' => '/usr/local/bin:/usr/bin:/bin'
        }
      end
    end
  end
end

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
  class ConsulAgentServiceSystemd < ConsulAgentService
    use_automatic_resource_name

    provides :consul_agent_service, platform: 'fedora'
    provides :consul_agent_service, platform: %w(redhat centos scientific oracle) do |node| # ~FC005
      node['platform_version'].to_f >= 7.0
    end
    provides :consul_agent_service, platform: 'debian' do |node|
      node['platform_version'].to_i >= 8
    end
    provides :consul_agent_service, platform_family: 'suse' do |node|
      node['platform_version'].to_f >= 13.0
    end
    provides :consul_agent_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f >= 15.10
    end

    action_class.class_eval do
      def service_file
        "/etc/systemd/system/#{consul_service_name}.service"
      end

      def create_init
        ensure_config
        create_directories

        template service_file do
          source 'systemd.service.erb'
          owner 'root'
          group 'root'
          mode '0755'
          variables(
            name: consul_service_name,
            directory: new_resource.data_dir,
            command: "#{new_resource.program} #{daemon_options}",
            environment: new_resource.environment || default_environment,
            stop_signal: new_resource.stop_signal,
            service_user: new_resource.user
          )
          notifies :run, "execute[#{consul_service_name} daemon-reload]", :immediately
          if new_resource.restart_on_update && ::File.exist?(service_file)
            notifies :restart, "consul_agent_service[#{consul_service_name}]", :delayed
          end
        end

        execute "#{consul_service_name} daemon-reload" do
          command 'systemctl daemon-reload'
          action :nothing
        end
      end
    end
  end
end
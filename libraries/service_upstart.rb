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
  class ConsulAgentServiceUpstart < ConsulAgentService
    use_automatic_resource_name

    provides :consul_agent_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f < 15.10
    end

    action_class.class_eval do
      def service_file
        "/etc/init/#{consul_service_name}.conf"
      end

      def create_init
        create_directories

        template "/etc/init/#{consul_service_name}.conf" do
          source 'upstart.service.erb'
          cookbook 'consul_agent'
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
          if new_resource.restart_on_update && ::File.exist?(service_file)
            notifies :restart, "consul_agent_service[#{consul_service_name}]", :delayed
          end
        end
      end
    end
  end
end

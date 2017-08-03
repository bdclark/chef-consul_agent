
default['consul_agent']['version'] = '0.9.0'
default['consul_agent']['checksum'] = nil
default['consul_agent']['diplomat_version'] = nil

default['consul_agent']['create_service_user'] = true
default['consul_agent']['service_user'] = 'consul'
default['consul_agent']['service_group'] = 'consul'
default['consul_agent']['restart_on_update'] = true

default['consul_agent']['service_uid'] = nil
default['consul_agent']['service_gid'] = nil

default['consul_agent']['bin_dir'] = '/usr/local/bin'
default['consul_agent']['config_path'] = '/etc/consul/config.json'
default['consul_agent']['config_dir'] = '/etc/consul/conf.d'
default['consul_agent']['log_dir'] = '/var/log/consul' # sysvinit only
default['consul_agent']['stop_signal'] = 'TERM'

default['consul_agent']['serve_web_ui'] = false
default['consul_agent']['web_ui_dir'] = '/opt/consul-webui'

default['consul_agent']['config']['data_dir'] = '/var/lib/consul'
default['consul_agent']['config']['client_addr'] = '0.0.0.0'
default['consul_agent']['config']['ports'] = {
  dns: 8600,
  http: 8500,
  rpc: 8400,
  serf_lan: 8301,
  serf_wan: 8302,
  server: 8300
}

default['consul_agent']['dnsmasq']['network_manager_enabled'] = false
default['consul_agent']['dnsmasq']['upstream_servers'] = []

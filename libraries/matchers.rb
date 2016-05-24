if defined?(ChefSpec)
  def create_consul_agent_install(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_install, :create, res_name)
  end

  def remove_consul_agent_install(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_install, :remove, res_name)
  end

  def create_consul_agent_web_ui(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_web_ui, :create, res_name)
  end

  def remove_consul_agent_web_ui(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_web_ui, :remove, res_name)
  end

  def create_consul_agent_config(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_config, :create, res_name)
  end

  def delete_consul_agent_config(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_config, :delete, res_name)
  end

  def create_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :create, res_name)
  end

  def enable_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :enable, res_name)
  end

  def disable_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :disable, res_name)
  end

  def start_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :start, res_name)
  end

  def stop_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :stop, res_name)
  end

  def restart_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :restart, res_name)
  end

  def reload_consul_agent_service(res_name)
    ChefSpec::Matchers::ResourceMatcher.new(:consul_agent_service, :reload, res_name)
  end
end

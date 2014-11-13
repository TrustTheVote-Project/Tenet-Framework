def load_config(name)
  path = File.join(Rails.root, 'config', name)

  if File.exists?(path)
    config = YAML.load_file(path)
    env_config = config.delete(Rails.env)
    config.merge!(env_config) unless env_config.nil?
  else
    config = {}
  end

  config
end

TenetConfig = load_config('tenet_config.yml')

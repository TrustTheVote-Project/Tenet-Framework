def load_config(name)
  config = YAML.load_file(File.join(Rails.root, 'config', name))
  env_config = config.delete(Rails.env)
  config.merge!(env_config) unless env_config.nil?
  config
end

CsfConfig = load_config('csf_config.yml')

if !Rails.env.development? && !Rails.env.test?
  ENV = YAML.load_file("#{::Rails.root}/config/config.yml")[::Rails.env]
end

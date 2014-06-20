
ENV2 = YAML.load_file("#{::Rails.root}/config/config.yml")[::Rails.env]

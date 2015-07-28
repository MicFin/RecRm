Rails.application.configure do
  config.lograge.enabled = true

  # add time to lograge
  config.lograge.custom_options = lambda do |event|
    # {:time => event.time}
     params = event.payload[:params].reject do |k|
      ['controller', 'action'].include? k
    end

    { "params" => params, :time => event.time }
  end

  # config.lograge.custom_options = lambda do |event|
  #   params = event.payload[:params].reject do |k|
  #     ['controller', 'action'].include? k
  #   end

  #   { "params" => params }
  # end
end
Rails.application.configure do
  config.lograge.enabled = true

  # add time to lograge
  config.lograge.custom_options = lambda do |event|
    # {:time => event.time}
     params = event.payload[:params].reject do |k|
      ['controller', 'action', 'format'].include? k
    end

    { "params" => params, :time => event.time }
  end

  # config.lograge.custom_options = lambda do |event|
  #   params = event.payload[:params].reject do |k|
  #     ['controller', 'action'].include? k
  #   end

  #   { "params" => params }
  # end

 
# # custom_options can be a lambda or hash
# # if it's a lambda then it must return a hash
#   config.lograge.custom_options = lambda do |event|
#     unwanted_keys = %w[format action controller]
#     params = event.payload[:params].reject { |key,_| unwanted_keys.include? key }
 
#     # capture some specific timing values you are interested in
#     {:params => params }
#   end



end
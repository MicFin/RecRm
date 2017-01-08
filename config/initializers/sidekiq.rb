# It is important to note that to configure the location of Redis, you must define both the Sidekiq.configure_server and Sidekiq.configure_client blocks. To do this put the following code into config/initializers/sidekiq.rb.

# if Rails.env.development?
  Sidekiq.configure_server do |config|
    config = ActiveRecord::Base.configurations[Rails.env] ||
         Rails.application.config.database_configuration[Rails.env]

    config['pool'] = Sidekiq.options[:concurrency] + 2
     
    ActiveRecord::Base.establish_connection(config)
     
    Rails.logger.debug("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")

    config.redis = { url: 'redis://localhost:6379/0', network_timeout: 5 }
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0', network_timeout: 5 }
  end

# else

#   Sidekiq.configure_server do |config|
#     config.redis = { url: 'redis://54.191.134.234:6379/0', network_timeout: 5 }
#   end

#   Sidekiq.configure_client do |config|
#     config.redis = { url: 'redis://54.191.134.234:6379/0', network_timeout: 5 }
#   end
# end


# NOTE: Unknown parameters are passed to the underlying Redis client so any parameters supported by the driver can go in the Hash.

# NOTE: The configuration hash must have symbolized keys.

# # 
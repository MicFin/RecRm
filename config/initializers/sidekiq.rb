# It is important to note that to configure the location of Redis, you must define both the Sidekiq.configure_server and Sidekiq.configure_client blocks. To do this put the following code into config/initializers/sidekiq.rb.

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0', network_timeout: 5 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0', network_timeout: 5 }
end
# NOTE: Unknown parameters are passed to the underlying Redis client so any parameters supported by the driver can go in the Hash.

# NOTE: The configuration hash must have symbolized keys.

# # 
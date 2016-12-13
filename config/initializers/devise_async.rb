# http://yerb.net/blog/2014/04/16/sending-emails-asynchronously-with-devise-and-sidekiq/
# https://github.com/mperham/sidekiq/wiki/Advanced-Options

# Devise::Async.backend = :sidekiq
# Devise::Async.queue = :my_custom_queue
# Devise::Async.priority = 10

Devise::Async.setup do |config|
  config.enabled = true
  config.backend = :sidekiq
  config.queue   = :default
end
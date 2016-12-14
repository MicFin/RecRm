Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.


  # # config.stripe.eager_load = ['user']
  # # turned serve static assets to false for 
  # # stoping ajax from being cached and caling itself twice
  # config.serve_static_assets = false
  # turned serve static assets to true for carrierview images not loading from pbulic folder
  config.serve_static_assets = true
  
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true

  # Change to true when working on cache in developement
  # config.action_controller.perform_caching = false
  config.action_controller.perform_caching = false
  # config.perform_caching = true

    # config.cache_store = :mem_cache_store
  # config.cache_store = :dalli_store
  # config.identity_cache_store = :mem_cache_store, Dalli::Client.new(:servers => ["mem1.server.com"])

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true


  #Mail functions for devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  # http://mailcatcher.me/ run mailcatcher and go to http://127.0.0.1:1080/
  config.action_mailer.smtp_settings = {:address => "localhost", :port => "1025"}
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true


  # Initialize Bullet
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    # Bullet.bullet_logger = true
    Bullet.console = true
    # Bullet.growl = true
    # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
    #                 :password => 'bullets_password_for_jabber',
    #                 :receiver => 'your_account@jabber.org',
    #                 :show_online_status => true }
    # Bullet.rails_logger = true
    # Bullet.honeybadger = true
    # Bullet.bugsnag = true
    # Bullet.airbrake = true
    # Bullet.rollbar = true
    # Bullet.add_footer = true
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]
    # Bullet.slack = { webhook_url: 'http://some.slack.url', foo: 'bar' }
    
    # Each of these settings defaults to true
    # # Detect N+1 queries
    # Bullet.n_plus_one_query_enable     = false
    # # Detect eager-loaded associations which are not used
    # Bullet.unused_eager_loading_enable = false
    # # Detect unnecessary COUNT queries which could be avoided
    # # with a counter_cache
    # Bullet.counter_cache_enable        = false
  end
end

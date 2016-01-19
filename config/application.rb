require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # # NOT USING
    # config.before_initialize do
    #   ENV['PATH'] += File::PATH_SEPARATOR + '/usr/local/bin'
    # end

    # NOT SURE THIS IS NECESSARY
    if Rails.env.production?
      config.stripe.publishable_key = 'pk_live_eKJSALzXBAibHjg97Osuzfdm'
    else
      config.stripe.publishable_key = 'pk_test_cZieXcu5WhjQKKDCmOY0PtoA'
    end
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.

    # set time zone default to EST
    # http://railscasts.com/episodes/106-time-zones-revised?view=asciicast
    # removed due to advice in 
    # http://jessehouse.com/blog/2013/11/15/working-with-timezones-and-ruby-on-rails/
    # config.time_zone = 'Eastern Time (US & Canada)'

    config.action_view.embed_authenticity_token_in_remote_forms = true
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    initializer 'setup_asset_pipeline', :group => :all  do |app|
      # We don't want the default of everything that isn't js or css, because it pulls too many things in
      app.config.assets.precompile.shift

      # Explicitly register the extensions we are interested in compiling
      app.config.assets.precompile.push(Proc.new do |path|
        File.extname(path).in? [
          '.html', '.erb', '.haml', '.scss',                 # Templates
          '.png',  '.gif', '.jpg', '.jpeg',         # Images
          '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
        ]
      end)
    end
    

    # ENV['PATH'] = "/usr/local/bin:#{ENV['PATH']}"
    # ENV['PATH'] = "/usr/bin:#{ENV['PATH']}"
    # ENV['PATH'] += File::PATH_SEPARATOR + '/usr/local/bin'
    ENV['PATH'] += File::PATH_SEPARATOR + '/usr/bin'
  end
end

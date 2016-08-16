# # Gem Sources
source 'http://rubygems.org'

# # Ruby
ruby '2.1.5'

# gemspec

# # Rails
gem 'rails', '4.1.1'

# # Data
gem 'pg', '0.17.1'
gem 'jbuilder', '~> 2.0'                              # https://github.com/rails/jbuilder

# # LINUX
# gem 'rb-inotify', :group => [:development, :test]   # monitor file changes without hammering the disk

# # MiddleWare 
gem 'route_downcaser', "1.1.4"                      # https://github.com/carstengehling/route_downcaser 
gem 'browser_details', "0.0.6"                      # https://github.com/gshutler/browser_details
gem "lograge", "0.3.4"                              # https://github.com/roidrage/lograge

# # Javascript
gem 'jquery-rails', '~> 3.1.2'
gem 'turbolinks', "2.2.2"                             # https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
gem 'jquery-ui-rails', "4.2.1"
gem 'jquery-datatables-rails', '~> 3.3.0'
# gem 'nprogress-rails'

# # Assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass', '~> 3.1.1.1'
gem 'simple_form', "3.2.0"
gem 'active_link_to', "1.0.3"                       # https://github.com/comfy/active_link_to
gem 'acts_as_list', "0.3.0"                         # https://github.com/swanandp/acts_as_list
gem 'css_splitter', "0.4.2"                         # https://github.com/zweilove/css_splitter
# gem 'haml-rails'
# gem 'headjs-rails'

# # Video Conferencing
gem "opentok", "2.2.1"                              # https://github.com/opentok/Opentok-Ruby-SDK

# # Dates, Time and Phone
gem 'fullcalendar-rails', '~> 2.3.1'
gem 'momentjs-rails', '~> 2.8.4'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'phony_rails', "0.6.1"

# # CoffeeScript
gem 'coffee-rails', '~> 4.0.0'

# # Authentication
gem 'devise', "3.2.4"
gem 'devise_invitable', '~> 1.3.4'          # https://github.com/scambra/devise_invitable
gem "pundit", "0.2.2"                       # https://github.com/elabs/pundit
gem 'rolify', "3.4.1"                       # https://github.com/RolifyCommunity/rolify
# gem 'omniauth'
# gem 'omniauth-facebook'
# gem 'omniauth-twitter'
# # gem 'omniauth-persona'
# # gem 'omniauth-google-oauth2'
# # gem 'omniauth-linkedin'

# # Payments
gem 'stripe', "1.16.0"
gem 'stripe-rails', "0.3.1"                   # # https://github.com/thefrontside/stripe-rails

# # Admin
# gem 'activeadmin', github: 'gregbell/active_admin'        # http://activeadmin.info/
gem "rails-settings-cached", '0.4.1'          # https://github.com/huacnlee/rails-settings-cached

# # File Uploads
gem 'carrierwave', "0.10.0"
gem 'mini_magick', "4.3.6"
gem 'carrierwave-aws', "1.0.0"
gem 'remotipart', '~> 1.2'
gem 'file_validators'
# gem 'rmagick'
# gem "cocoon"

# # Blog
gem 'monologue', "0.4.1"
# gem 'comfortable_mexican_sofa', '~> 1.12.0'

# # Monitoring
gem "airbrake"
gem 'newrelic_rpm'
# gem 'airbrake_user_attributes'                       # see config/initializers/airbrake.rb
# gem 'rack-timeout', '~> 0.1.0beta3'
# # gem 'rack-google-analytics'

# # Web Scraping
gem 'nokogiri', '~> 1.6', '>= 1.6.7.2'

# # API
# gem 'rabl'
# gem 'oj'

# # Recurring Events
# gem "ice_cube"
# gem "recurring_select"

# # Design
# # gem 'bourbon'
# # gem 'neat'
# # gem 'country_select'

# # Email
gem 'rails_email_preview', '~> 1.0.3'
gem 'premailer-rails'
# gem 'roadie-rails', '~> 1.0'
# gem 'premailer-rails'

# # Workers
# gem 'sidekiq'
# gem 'devise-async'
# gem 'sinatra', require: false

# # Utils
# gem 'addressable'
# gem 'settingslogic'

# # Caching 
# # might be able to move into group :production
gem 'dalli'                                     # https://github.com/petergoldstein/dalli
# gem 'identity_cache'                            # https://github.com/Shopify/identity_cache
# gem 'cityhash'

# Rack Mini Profiler 
# runs in development but is installed out of the group, can be adjusted to run in production too
gem 'rack-mini-profiler'                        # https://github.com/MiniProfiler/rack-mini-profiler

group :production do
    # gem 'dalli'                               # https://github.com/petergoldstein/dalli
    # gem 'identity_cache'                      # https://github.com/Shopify/identity_cache
    # gem 'unicorn'
    # gem 'rails_12factor'                      # https://devcenter.heroku.com/articles/rails4
end

group :development do

  #   # Docs
  gem 'sdoc', '~> 0.4.0',          group: :doc
  gem 'annotate'                        # https://github.com/ctran/annotate_models

  #   # Errors
  gem "better_errors", "1.1.0"
  gem "binding_of_caller", "0.7.2"     # extra features for better_errors
  gem 'sextant', "0.2.4"               # https://github.com/schneems/sextant
  gem "bullet"                         # https://github.com/flyerhzm/bullet
  gem 'meta_request'                   # https://github.com/dejan/rails_panel
  #    gem 'traceroute'        # https://github.com/amatsuda/traceroute

  #   # Security
  # gem 'brakeman', :require => false     # https://github.com/presidentbeef/brakeman

  #   # Deployment
  #   # gem 'capistrano'

  #   # Guard
  #   gem 'guard-rspec'
  #   # gem 'guard-livereload'
  #   # gem 'rack-livereload'
end

group :development, :test do

  gem 'spring', "1.1.3"             # https://github.com/rails/spring
  #   gem 'spring-commands-rspec'   # keep application running in the background
  #   # gem 'zeus'                  # required in gemfile for guard

  #   # Debugging
  gem 'pry', "0.10.0"               # better than irb
  #   # gem 'byebug'                # ruby 2.0 debugger with built-in pry
  #   gem 'pry-rails'               # adds rails specific commands to pry
  #   gem 'pry-byebug'              # add debugging commands to pry
  #   gem 'pry-stack_explorer'      # navigate call stack
  #   # gem 'pry-rescue'            # start pry session on uncaught exception
  #   # gem 'pry-doc'               # browse docs from console
  #   # gem 'pry-git'               # add git support to console
  #   # gem 'pry-remote'            # connect remotely to pry console
  #   # gem 'coolline'              # sytax highlighting as you type
  #   # gem 'coderay'               # use with coolline
  #   gem 'awesome_print'           # pretty pring debugging output

  #   # Testing
    # gem 'rspec-rails'
  #   gem 'factory_girl_rails'
  #   gem 'ffaker'
  #   gem 'capybara-webkit'
  #   # gem 'poltergeist'           # alternative to capybara-webkit
  #   # gem 'capybara-firebug'
  #   # gem 'launchy'               # save_and_open_page support for rspec
  #   # gem 'zeus-parallel_tests'   # speed up lengthy tests

  #   # Logging
  #   gem 'quiet_assets'
end

# group :test do
  #   gem 'minitest'                # include minitest to prevent require 'minitest/autorun' warnings

  #   # Helpers
  #   gem 'shoulda-matchers'
  #   gem 'database_cleaner'
  #   # gem 'timecop'               # Mock Time

  #   # Coverage
  #   gem 'simplecov', require: false
  #   # gem 'coveralls', :require => false

  #   gem 'rspec-sidekiq'
# end


# gem "elasticsearch", git: "git://github.com/elasticsearch/elasticsearch-ruby.git"
# gem "elasticsearch-model", git: "git://github.com/elasticsearch/elasticsearch-rails.git"
# gem "elasticsearch-rails", git: "git://github.com/elasticsearch/elasticsearch-rails.git"



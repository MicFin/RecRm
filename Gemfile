source 'http://rubygems.org'
ruby '2.1.5'

# not sure whether to use gemspec so removed it
# gemspec

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '0.17.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', "2.2.2"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# responsive design css and javascript
gem 'bootstrap-sass', '~> 3.1.1.1'

# user authorization
gem 'devise', "3.2.4"

# Adds support to devise for sending invitations by email (it requires to be authenticated) and accept the invitation setting the password.
# https://github.com/scambra/devise_invitable
gem 'devise_invitable', '~> 1.3.4'

gem 'jquery-turbolinks'

# unitwise is a cross platform list of units and their conversions
# https://github.com/joshwlewis/unitwise
# I found this tutorial useful for adding units to the ingredients_recipes model 

# http://joshwlewis.com/essays/rails-unit-measurement-persistence/
# gem 'unitwise'

# simple form makes forms easier and prettier to write and plays nice with bootstrap
# https://github.com/plataformatec/simple_form
#   Inside your views, use the 'simple_form_for' with one of the Bootstrap form classes, '.form-horizontal', '.form-inline', '.form-search' or '.form-vertical', as the following: simple_form_for(@user, html: {class: 'form-horizontal' }) do |form|
gem 'simple_form', "3.0.2"

# # For autofilling fields form database. It is rails 4 compatible, don't be fooled by the name.
# # https://github.com/crowdint/rails3-jquery-autocomplete
# gem 'rails3-jquery-autocomplete'

# Required to use with gem 'rails3-jquery-autocomplete' 
# only requiring widget //= require jquery.ui.autocomplete
gem 'jquery-ui-rails', "4.2.1"

# allows image uploads
# gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

# gem "paperclip", github: 'thoughtbot/paperclip'
## storing images in aws s3 bucket
# gem 'aws-sdk'

# http://railscasts.com/episodes/253-carrierwave-file-uploads?view=asciicast
gem 'carrierwave', "0.10.0"
gem "rmagick", "2.13.4"
# http://railscasts.com/episodes/383-uploading-to-amazon-s3?view=asciicast
# gem 'fog', "~> 1.3.1"
gem 'carrierwave-aws', "0.4.1"

gem 'momentjs-rails', '~> 2.8.4'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.3'

# manages phone number validation
gem 'phony_rails', "0.6.1"

# video conferencing 
gem "opentok", "2.2.1"


# creates AdminUser model, migrations, controllers, routing, views, etc for an administrative user with dashboard.  Very Ruby friendly and customizable.  Will use AdminUser as our tech admin but can register other User models with ActiveAdmin and give certain permissions
# http://activeadmin.info/
gem 'activeadmin', github: 'gregbell/active_admin'
# gem 'activeadmin', '1.0.0.pre'

# This acts_as extension provides the capabilities for sorting and reordering a number of objects in a list. The class that has this specified needs to have a position column defined as an integer on the mapped database table. https://github.com/swanandp/acts_as_list
gem 'acts_as_list', "0.3.0"

# Minimal authorization through OO design and pure Ruby classes
# https://github.com/elabs/pundit
gem "pundit", "0.2.2"
 
# https://github.com/RolifyCommunity/rolify
gem 'rolify', "3.4.1"

# javascript calendar 
gem 'fullcalendar-rails', '~> 2.3.1'

# rails stripe payment integration
# https://github.com/thefrontside/stripe-rails
gem 'stripe', "1.16.0"
gem 'stripe-rails', "0.3.1"

# rails URL downcaser uses Rack middleware to make URLs case insensitive.
# all image file names and url's should be all lower case to work consistently
# customization in config/initializers/route_downcaser.rb
# https://github.com/carstengehling/route_downcaser 
gem 'route_downcaser', "1.1.4"

# browser details for server requests
# https://github.com/gshutler/browser_details
gem 'browser_details', "0.0.6"

# minimizes rails logs for better reading
# https://github.com/roidrage/lograge
gem "lograge", "0.3.4"

# active links helper method
# https://github.com/comfy/active_link_to
# https://github.com/comfy/active_link_to/issues/14
gem 'active_link_to', "1.0.3"

# This is a simple gem which bundles jstimezonedetect and a jquery plugin for it
# https://github.com/scottwater/detect_timezone_rails
# gem 'detect_timezone_rails'

# automatic cron jobs
# user for payments and emails?
# https://github.com/javan/whenever
# gem 'whenever', require: false

# # http://axlsx.blog.randym.net/2011/12/using-actsasxlsx-to-generate-excel-data.html
# # https://github.com/straydogstudio/acts_as_xlsx
# # xlsx generation with charts, images, automated column width, customizable styles and full schema validation. 
# gem 'acts_as_xlsx', "1.0.6", :github => "straydogstudio/acts_as_xlsx"

# # https://github.com/straydogstudio/axlsx_rails
# # A Rails plugin to provide templates for the axlsx gem
# gem 'axlsx_rails', "0.3.0"

# Splits CSS files to avoid limit for IE9 and below 
# https://github.com/zweilove/css_splitter
gem 'css_splitter'

# blogging engine
# https://github.com/jipiboily/monologue
gem 'monologue', "0.4.1"

group :development do
# Better error gives you better explanations for errors
# https://github.com/charliesome/better_errors
  gem "better_errors", "1.1.0"
# binding of caller allows you to do variable inspection with better errors  
  gem "binding_of_caller", "0.7.2"
# Pry allows you to debug, place a binding.pry in ruby code and you can debug from that place in the console
  gem 'pry', "0.10.0"
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', "1.1.3"

# find your route on a long journey over Rails with Sextant
# go to http://localhost:3000/rails/routes to view routes, faster than rails routes
#https://github.com/schneems/sextant
  gem 'sextant', "0.2.4"

end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# # Use debugger
# gem 'debugger'


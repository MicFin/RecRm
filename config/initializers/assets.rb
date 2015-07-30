

# controller specific assets so that the controller.scss is compiled 
# turned off .tree in app.css
# same with app.js
# http://theflyingdeveloper.com/controller-specific-assets-with-rails-4/
%w( welcome families landing_pages rooms ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.css", "#{controller}.js"]
end

# precompiles polyfills that are only loaded when Modernizr needs them
# http://blog.endpoint.com/2013/05/using-modernizr-with-rails-asset.html
# PIE 
# selectivizr 
# require-js.min 
# placeholder.min 
# respond.min
%w( PIE selectivizr require-js.min placeholder.min respond.min ).each do |polyfill|
  Rails.application.config.assets.precompile += ["browser_specific/polyfills/#{polyfill}.js"]
end

# precompiles polyfills that are only loaded when Modernizr needs them
# http://blog.endpoint.com/2013/05/using-modernizr-with-rails-asset.html
  Rails.application.config.assets.precompile += ["*stylesheets/partials/browser_specific*"]


# controller specific assets so that the controller.scss is compiled 
# turned off .tree in app.css
# same with app.js
# http://theflyingdeveloper.com/controller-specific-assets-with-rails-4/
%w( 
  welcome 
  families 
  landing_pages 
  rooms 
  time_slots 
  availabilities
  packages
  coupons
  users/sessions
  survey_groups
  ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.css", "#{controller}.js"]
end

# precompile IE specific css and JS
# https://stackoverflow.com/questions/7134034/using-rails-3-1-assets-pipeline-to-conditionally-use-certain-css
  Rails.application.config.assets.precompile += [
    "browser_specific/modernizr.min.js", 
    "browser_specific/modernizr_polyfills_rules.js"
  ]

# precompiles JS polyfills that are only loaded when Modernizr needs them
# http://blog.endpoint.com/2013/05/using-modernizr-with-rails-asset.html

%w( PIE 
    selectivizr 
    require-js.min 
    placeholder.min 
    respond.min 
    ).each do |polyfill|
  Rails.application.config.assets.precompile += ["browser_specific/polyfills/#{polyfill}.js"]
end

# precompiles CSS polyfills that are only loaded when Modernizr needs them
# http://blog.endpoint.com/2013/05/using-modernizr-with-rails-asset.html
Rails.application.config.assets.precompile += [
  "stylesheets/modules/bootstrap/bootstrap_overrides/css3pie.css", 
  "stylesheets/modules/bootstrap/bootstrap_overrides/ie7.css", 
  "stylesheets/partials/browser_specific/landing_pages/qol.css"
]


# compile the split application.css pages that are needed for IE7 css limit
Rails.application.config.assets.precompile += ["application_split2.css", "application_split3.css", "application_split4.css"]

# compile ckeditor
Rails.application.config.assets.precompile += %w( ckeditor/* )



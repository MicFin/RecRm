
# http://theflyingdeveloper.com/controller-specific-assets-with-rails-4/
# controller specific assets so that the controller.scss is compiled 
# turned off .tree in app.css
# same with app.js
%w( welcome families landing_pages rooms).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js.coffee", "#{controller}.css", "#{controller}.js"]
end
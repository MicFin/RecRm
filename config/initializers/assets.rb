
# http://theflyingdeveloper.com/controller-specific-assets-with-rails-4/
# controller specific assets so that the controller.scss is compiled 
# turned off .tree in app.css
%w( welcome ).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js.coffee", "#{controller}.css"]
end
class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

  	

	def after_sign_in_path_for(resource)
		if resource.class == User
		    if resource.sign_in_count <= 1
		      # if first time give first time user experience
		      home_path
		    else
		      # if not take them to their home page
		      home_path
		    end
		end
	end

end

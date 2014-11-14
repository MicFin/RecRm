class ApplicationController < ActionController::Base
	include Pundit
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	after_filter :dietitian_activity
  	

	def after_sign_in_path_for(resource)
		if resource.class == User

		    if resource.appointment_hosts.last
		    	if resource.appointment_hosts.last.start_time
		    		# if not take them to their home page
		      	user_dashboard_path(resource.id)
		     	else 
		     		new_user_intro_path(resource.id) 
		     	end
		    else
		      # if first time give first time user experience
		      new_user_intro_path(resource.id) 
		    end
		elsif resource.class == Dietitian
				if resource.sign_in_count <= 1
		      # if first time give first time user experience
		      # would rather it direct to dietitian_authenticated_root_path but failing
		      ### dietitian_authenticated_root_path(current_dietitian)
		      ### dietitian_authenticated_root_path
					dietitian_recipes_path(resource)
		    else
		      # if not take them to their home page
					dietitian_recipes_path(resource)
		    end
		elsif resource.class == AdminUser
				if resource.sign_in_count <= 1
		      # if first time give first time admin experience
		      # would rather it direct to admin_user_authenticated_root_path but failing
		      ### admin_user_authenticated_root_path(current_admin_user)
		      ### admin_user_authenticated_root_path
					admin_dashboard_path
		    else
		      # if not take them to their home page
					admin_dashboard_path
		    end
		end

	end

private

	def dietitian_activity
	  current_dietitian.try :touch
	end

  

end

class ApplicationController < ActionController::Base
	include Pundit
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	after_filter :dietitian_activity

  # shared by the user and dietitian registrations controllers
	def after_sign_in_path_for(resource)
		# if class is User
		if resource.class == User

		  # take them to the welcome home
		  welcome_home_path(resource.id)

		elsif resource.class == Dietitian
				if resource.sign_in_count <= 1
		      # if first time give first time user experience
		      # would rather it direct to dietitian_authenticated_root_path but failing
		      ### dietitian_authenticated_root_path(current_dietitian)
		      dietitian_authenticated_root_path(resource)
					# dietitian_recipes_path(resource)
		    else
		      # if not take them to their home page
					# dietitian_recipes_path(resource)
					dietitian_authenticated_root_path(resource)
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

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      # new_user_session_path
      root_path
    else
    	root_path
    end
  end
  

end

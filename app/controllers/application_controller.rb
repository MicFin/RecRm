class ApplicationController < ActionController::Base
	include Pundit
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	after_filter :dietitian_activity

  # shared by the user and dietitian registrations controllers
	def after_sign_in_path_for(resource)
    
    #note: request.referrer can be used to return user to the page they were on
    
		# when a user signs in 
    
		if resource.class == User
      
      # update user registration stage
      resource.update_registration_stage
      
      # check if user has completed on boarding 
      if resource.finished_on_boarding? 

        welcome_home_path
      # if user has not completed onboarding
      else
        # 
        # registration_stage = resource.registration_stage
        # # user has only confirmed their account 
        # if registration_stage == 1

          welcome_get_started_path

        # else
        # end
      end
 
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


  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    
    if resource_or_scope == :user
      # new_user_session_path
      root_path
    else
    	root_path
    end
  end

  #   # Users that require confirmation, currently from QOL landing page
  # # only QOL admin should be creating these so can redirect to qol
  # def after_inactive_sign_up_path_for(resource)
  #   
  #   redirect_to landing_pages_qol_admin_path
  # end
  

end

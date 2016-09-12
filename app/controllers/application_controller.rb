class ApplicationController < ActionController::Base
	include Pundit
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

  # Show currently logged in dietitians if Admin Dietitian
	after_filter :dietitian_activity

  # Set system time zone is current user
  # http://railscasts.com/episodes/106-time-zones-revised?view=asciicast
  around_filter :user_time_zone, :if => proc {current_user}

  # shared by the user and dietitian registrations controllers
	def after_sign_in_path_for(resource)
    
    #note: request.referrer can be used to return user to the page they were on

    # If the resource is a dietitian
    if resource.class == Dietitian
        dietitian_authenticated_root_path(resource)

    # Else resource is a user
    else

      # if user is a provider
      if resource.provider?

        new_user_invitation_path

      # if user is not a provider
      else

        # update user registration stage
        resource.update_registration_stage
        
        # if user has completed onboarding then send to welcome home
        if resource.finished_on_boarding? 
          welcome_home_path

        # if user has not completed onboarding then send to get started path
        else
            welcome_get_started_path
        end
      end
		end

	end

  def after_invite_path_for(resource_name)
    if current_user.provider?
      new_user_invitation_path
    end
  end

  # def after_accept_path_for(resource_name)
  #   
  # end
private

	def dietitian_activity
	  current_dietitian.try :touch
	end


  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    
    dietitian_unauthenticated_root_path
    
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block) 
  end
  
  #   # Users that require confirmation, currently from QOL landing page
  # # only QOL admin should be creating these so can redirect to qol
  # def after_inactive_sign_up_path_for(resource)
  #   
  #   redirect_to landing_pages_qol_admin_path
  # end
  

end

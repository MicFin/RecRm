class WelcomeController < ApplicationController
    include AppointmentsHelper
    include QualityReviewsHelper
		before_filter :check_user_logged_in!


    def index
      @date = Date.today 
      if @user == current_dietitian
        get_upcoming_appointments!
        @upcoming_appointments
        @next_appointment
        
        get_incomplete_quality_reviews!
        @incomplete_quality_reviews
      end
    end

  private

    def check_user_logged_in! 
    
      if current_user 
        @user = current_user
        # maybe do something else
      elsif current_dietitian
        # maybe do something
        @user = current_dietitian
      else
      	# might want to do something later
      end
    end
end

class WelcomeController < ApplicationController
		before_filter :check_user_logged_in!

    def index
      date = Date.today 
      if @user == current_dietitian
        @appointments = current_dietitian.appointments.where(start_time: date..10.days.from_now)
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

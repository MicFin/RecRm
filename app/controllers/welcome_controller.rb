class WelcomeController < ApplicationController
		before_filter :check_user_logged_in!



  private

    def check_user_logged_in! 
      if current_user 
        redirect_to home_path
      else
      	# might want to do something later
      end
    end
end

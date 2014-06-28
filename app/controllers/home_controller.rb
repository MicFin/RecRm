class HomeController < ApplicationController
	before_filter :check_user_logged_in!



  private

    def check_user_logged_in! 
      if current_user 
        true
      else
        authenticate_user!
      end
    end

end

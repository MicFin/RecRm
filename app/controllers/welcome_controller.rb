class WelcomeController < ApplicationController
		before_filter :check_user_logged_in!

    def index

    end

  private

    def check_user_logged_in! 
    
      if current_user 
        # maybe do something else
      else
      	# might want to do something later
      end
    end
end

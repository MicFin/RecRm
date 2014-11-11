class WelcomeController < ApplicationController
		before_filter :check_user_logged_in!

    def index
      binding.pry
    end

  private

    def check_user_logged_in! 
      binding.pry
      if current_user 
        # maybe do something else
      else
      	# might want to do something later
      end
    end
end

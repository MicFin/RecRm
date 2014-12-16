class WelcomeController < ApplicationController
    include AppointmentsHelper
    include QualityReviewsHelper
		before_filter :check_user_logged_in!


    def index
      
      @today = Date.today
      @beginning_of_week = @today.at_beginning_of_week(:thursday)
      if @user == current_dietitian
        get_upcoming_appointments!
        @upcoming_appointments
        @next_appointment
        @user.quality_review_quota_count = @user.content_quotas.first.quality_reviews
        @user.quality_review_quota_completed_count = @user.quality_reviews.where(:created_at => @beginning_of_week.beginning_of_day..@today.end_of_day, completed: true).count
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

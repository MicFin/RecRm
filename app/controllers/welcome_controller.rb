class WelcomeController < ApplicationController
    include AppointmentsHelper
    include QualityReviewsHelper
    include FamiliesHelper
		before_filter :check_user_logged_in!


    # user home page / main dashboard
    def home

      # AppointmentsHelper
      get_previous_appointments!
      @previous_appointments
      get_upcoming_appointment!
      @upcoming_appointment
      # all clients recipes 
      @recipes 
      # all clients articles
      @articles 
      # FamiliessHelper
      get_family!
      @family
      @family_members
      # for survey
      # @survey = @appointment.surveys.where(survey_type: "Pre-Appointment-Client").where(completed: false).last

      # for survey
      # if @survey
      #   @surveyable = @appointment
      # end      
    end



    ### this is currently the dietitian's dashboard
    def index
      @today = Date.today
      @beginning_of_week = @today.at_beginning_of_week(:thursday)
      if @user == current_dietitian
        
        # AppointmentsHelper
        get_upcoming_appointments!
        @upcoming_appointments
        @next_appointment
        get_previous_appointments!
        @previous_appointments
        

        if @user.content_quotas.first != nil 
          @user.quality_review_quota_count = @user.content_quotas.first.quality_reviews
        else
          @user.quality_review_quota_count = 0;
        end
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

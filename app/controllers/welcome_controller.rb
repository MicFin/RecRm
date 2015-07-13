class WelcomeController < Users::RegistrationsController
    include AppointmentsHelper
    # include QualityReviewsHelper
    include PatientGroupsHelper
    include FamiliesHelper
		before_filter :check_user_logged_in!


    # user home page / main dashboard
    def home

binding.pry
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

    def get_started
      
      @user = current_user
      if @user.registration_stage == 3
        redirect_to welcome_add_nutrition_path
      elsif @user.registration_stage == 2
        redirect_to welcome_add_family_path
      else
        render :get_started
      end
    end

  def add_family

    # @family = Family.new
    @new_user = User.new(last_name: @user.last_name)

  end

  def build_family
    
    @family = @user.head_of_families.create(name: "Main")
    @user.add_role "Head of Family", @family

    clean_height_and_weight_input
    
    if params[:user][:family_role]
      @new_user = @family.users.create(devise_parameter_sanitizer.sanitize(:sign_up))
      @new_user.add_role "Family Member Account"
      @new_user.add_role "Family Member", @family
      @new_user.save
      redirect_to welcome_get_started_path(@new_user)
    else
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      redirect_to welcome_get_started_path
    end
    
    def add_nutrition
      
      @user = @user.head_of_families.last.users.last || @user

      # PatientGroupsHelper
      get_patient_groups!
      @diseases = @diseases 
      @intolerances = @intolerances 
      @allergies = @allergies
        
    end

    def build_nutrition
      
      @user = @user.head_of_families.last.users.last || @user

      # PatientGroupsHelper
      get_patient_groups!
      @diseases = @diseases 
      @intolerances = @intolerances 
      @allergies = @allergies
        
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



    def clean_height_and_weight_input
    if params["user"]
      if params["user"]["height"]
        if (params["user"]["height"]["feet"].to_i >= 1)
                params["user"]["height"]["feet"] = params["user"]["height"]["feet"].to_i * 12
                params["user"]["height_inches"] = params["user"]["height"]["feet"].to_i + params["user"]["height"]["inches"].to_i
        else 
            params["user"]["height_inches"] = params["user"]["height"]["inches"].to_i
        end
        params["user"].delete "height"
      end
      if params["user"]["weight"]
        if (params["user"]["weight"]["pounds"].to_i >= 1)
          params["user"]["weight"]["pounds"] = params["user"]["weight"]["pounds"].to_i * 16
          params["user"]["weight_ounces"] = params["user"]["weight"]["pounds"].to_i + params["user"]["weight"]["ounces"].to_i
        else 
            params["user"]["weight_ounces"] = params["user"]["weight"]["ounces"].to_i
        end
        params["user"].delete "weight"
      end
    end
  end
end

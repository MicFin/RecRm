class WelcomeController < Users::RegistrationsController
  include AppointmentsHelper
  include QualityReviewsHelper
  include PatientGroupsHelper
  include FamiliesHelper
	before_filter :check_user_logged_in!


  # User dashboard
  # /welcome/home
  def home
    # update registration for any old users that are already loggin in
    # can remove after older users' registration statuses are updated.
    current_user.update_registration_stage

    # if user isnt finished onboarding 
    if !current_user.finished_on_boarding?

      # then send them to get started
      redirect_to welcome_get_started_path and return
    end

    # Gather user's appointment data
    # from AppointmentsHelper
    get_previous_appointments!
    @previous_appointments
    get_upcoming_appointment!
    @upcoming_appointment
    @survey
    @surveyable
    get_unpaid_appointment!
    @unpaid_appointment

    # Gather user's recipe data 
    # To be continued...
    @recipes 

    # Gather user's articles data
    # To be continued...
    @articles 

    # Gather user's family data
    # from FamiliessHelper
    get_family!
    @family
    @family_members
    
    # Shows views/welcome/home.html.erb
  end

  ### This is currently the dietitian's dashboard
  ### Under construction
  ### /welcome/index
  def index

    # Get today's date
    @today = Date.today

    # Our content week starts on Thursday so set the beginning of the week to Thursday
    @beginning_of_week = @today.at_beginning_of_week(:thursday)

    # Check if user is a dietitian
    # Should not check if user is dietitian here
    # Add a before filter for welcome#index that makes sure the user is a dietian  
    # Under construction
    if @user == current_dietitian

      # AppointmentsHelper
      get_upcoming_appointments!
      @upcoming_appointments
      @next_appointment
      get_previous_appointments!
      @previous_appointments
      
      # Get quota count
      if @user.content_quotas.first != nil 
        @user.quality_review_quota_count = @user.content_quotas.first.quality_reviews
      else
        @user.quality_review_quota_count = 0;
      end

      # Get completed quota count
      @user.quality_review_quota_completed_count = @user.quality_reviews.where(:created_at => @beginning_of_week.beginning_of_day..@today.end_of_day, completed: true).count

      # Get reviews that are not completed
      get_incomplete_quality_reviews!
      @incomplete_quality_reviews

      # Shows views/welcome/index.html.erb
    end

  end

  # Checks where user is in the registration process and directs them to the correct path
  # welcome/get_started
  def get_started
    
    @user = current_user
    # Stage 1 - user confirmed but did not complete account set up
    if current_user.registration_stage == 1
      render :get_started

    # Stage 2 - user did not create family
    elsif current_user.registration_stage == 2
      redirect_to welcome_add_family_path

    # Stage 3 - user created family but did not save health groups
    elsif current_user.registration_stage == 3
      redirect_to welcome_add_nutrition_path

    # Stage 4 - user saved health groups but did not save diet
    elsif current_user.registration_stage == 4
      redirect_to welcome_add_preferences_path

    # Stage 5 - user did not set up appointment
    elsif current_user.registration_stage == 5
      redirect_to welcome_set_appointment_path

     # Done with registration, return to dashboard
    else
      redirect_to welcome_home_path
    end

  end

  # 1st stage of registration
  # Select who the appointment is for and build other family member if necessary
  # /welcome/add_family
  def add_family

    # get last new user or create a new user
    if current_user.head_of_families.where(name: "Main").first.users.length > 0
      @new_user = current_user.head_of_families.where(name: "Main").first.users.last
    else
      @new_user = User.new(last_name: @user.last_name)
    end

    # Shows views/welcome/add_family.html.erb
  end

  # Accepts form from welcome#add_family
  # /welcome/family
  # PATCH
  def build_family
    
    # Create new family with default name Main or find the Main family
    @family = current_user.head_of_families.find_or_create_by(name: "Main")

    # Give user role head of family 
    # Safe to reassign, does not override other roles or duplicate current
    @user.add_role "Head of Family", @family

    # Height and weight fields come in wrong format, need to clean for database.
    clean_height_and_weight_input
    
    # If submitted user has a family role then it means the user created a family member
    # Will duplicate family member even if one already exists 
    if params[:user][:family_role]
      
      # Create new family member and add roles
      @new_user = @family.users.create(devise_parameter_sanitizer.sanitize(:sign_up))
      @new_user.add_role "Family Member Account"
      @new_user.add_role "Family Member", @family
      @new_user.save

    # If no family role was submitted then user selected self 
    else

      # Update user profile
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))

    end

    # Set registration status
    # Should add to function current_user.update_registration_stage
    if current_user.registration_stage < 3
      current_user.registration_stage = 3
      current_user.save
    end

    # Send back to welcome#get_started to continue registration
    redirect_to welcome_get_started_path

  end

  # 2nd stage of registration
  # Select add nutritional information to the user profile 
  # /welcome/add_nutrition
  def add_nutrition
    
    # Gets family member if there is one or gets current user
    # Should make a before method
    @user = current_user.head_of_families.where(name: "Main").first.users.last || @user
    

    # set current patient group ids for checkbox form
    @user.patient_group_ids = @user.get_patient_group_ids

    # Gather all patient groups
    # from PatientGroupsHelper
    get_patient_groups!
    @diseases = @diseases 
    @intolerances = @intolerances 
    @allergies = @allergies

    # combine and then sort allergies and intolerances to replace just allergies
    @allergies.push(@intolerances).flatten!.sort_by{|word| word.order}

    # Shows /welcome/add_nutrition
  end

  # Accepts form from welcome#add_nutrition
  # /welcome/build_nutrition
  # PATCH
  def build_nutrition

    # Gets family member if there is one or gets current user
    # Should make a before method
    @user = current_user.head_of_families.where(name: "Main").first.users.last || @user
    
    # User may have submitted new health groups
    find_or_create_new_health_groups


    # Check if user has any preferences already
    user_preferences_ids = @user.get_preferences_ids
    if user_preferences_ids.count > 0  

      # Add preferences IDs to the params so that they get included when it updates the users health groups 
      user_preferences_ids.each {|id| params[:user][:patient_group_ids] << id}
    end

    # Update without password
    # Do not want user entering password for each update during registration
    @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    
    # Set registration status
    # Should add to function current_user.update_registration_stage
    if current_user.registration_stage < 4
      current_user.registration_stage = 4
      current_user.save
    end
    # Send back to welcome#get_started to continue registration
    redirect_to welcome_get_started_path
  
  end

  # 3rd stage of registration
  # Select add food preferences information to the user profile 
  # /welcome/add_preferences
  def add_preferences

    # Gets family member if there is one or gets current user
    # Should make a before method
    @user = current_user.head_of_families.where(name: "Main").first.users.last || @user
    
    # set current disease ids for checkbox form
    @user.patient_group_ids = @user.get_patient_group_ids

    # Gather diets and symptoms from patient groups
    # from PatientGroupsHelper
    get_patient_groups!
    @diets = @diets 
    @symptoms = @symptoms 

    # Shows /welcome/add_preferences    
  end

  # Accepts form from welcome#add_preferences
  # /welcome/build_preferences
  # PATCH
  def build_preferences

    # Gets family member if there is one or gets current user
    # Should make a before method
    @user = current_user.head_of_families.where(name: "Main").first.users.last || @user

    # User may have submitted new health groups
    find_or_create_new_health_groups

    # Check if any data was submitted
    if params[:user]

      # Check if user has any diseases
      user_disease_ids = @user.get_disease_ids
      if user_disease_ids.count > 0  

        # Add disease IDs to the params so that they get included when it updates the users health groups 
        user_disease_ids.each {|id| params[:user][:patient_group_ids] << id}
      end

    end

    # Update without password
    # Do not want user entering password for each update during registration
    @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))

    # Set registration status
    # Should add to function current_user.update_registration_stage
    if current_user.registration_stage < 5
      current_user.registration_stage = 5
      current_user.save
    end
    # Send back to welcome#get_started to continue registration
    redirect_to welcome_get_started_path 

  end

  # 4th stage of registration
  # Select appointment time and checkout
  # /welcome/set_appointment
  def set_appointment

    # Gets family member if there is one or gets current user
    # Should make a before method    
    patient_focus = current_user.head_of_families.where(name: "Main").first.users.last || @user
    
    # Create appointment
    # Should maybe use .new so that it doesn't save until purchased
    @appointment = Appointment.create(appointment_host_id: @user.id, patient_focus_id: patient_focus.id, status: "In Registration")

    # Fetch all available time slots
    # Might not need to do this since JS makes the call in timeslots.js for the calendar build
    @time_slots = TimeSlot.select_appointment_time_slots

    # Get any appointment requests the user has made
    @appointment_requests = Appointment.where(appointment_host_id: current_user.id).where(status: "Requested").order('start_time ASC, created_at ASC')
    
    # Shows /welcome/set_appointment
  end


  private

    def check_user_logged_in! 
      # Check if user is a dietitian or a user and set @user
      # Gets overriden in other methods, should reevaluate
      # Should check admin first then dietitian or be a user
      if current_user 
        @user = current_user
      elsif current_dietitian
        @user = current_dietitian
      else
        redirect_to dietitian_unauthenticated_root_path
      end

    end


    # If a user submits new health groups then check if they are in our database or create them and prepare them to be saved
    def find_or_create_new_health_groups

      # Check if user input was submitted
      if params["user"]

        # Check if health new health groups were submitted
        if params["user"]["new_health_groups"]

          #  Find or create new health groups and add them to the params to be saved
          params["user"]["new_health_groups"].each do |health_group|
             group = PatientGroup.find_or_create_by(name: health_group, unverified: true) 
             group.save
             params["user"]["patient_group_ids"].push(group.id)
          end

          # Delete the new health groups param
          params["user"].delete "new_health_groups"
        end 
      end
    end

    # Height and weight must be changed from ft+in and lb+oz to just inches and ounces before being saved
    def clean_height_and_weight_input

      # Check if user input was submitted
      if params["user"]

        # Check if user height was submitted
        if params["user"]["height"]

          # Check if user height feet was submitted
          if (params["user"]["height"]["feet"].to_i >= 1)

            # Convert feet to inches
            params["user"]["height"]["feet"] = params["user"]["height"]["feet"].to_i * 12

            # Add to inches to get a total in inches
            params["user"]["height_inches"] = params["user"]["height"]["feet"].to_i + params["user"]["height"]["inches"].to_i

          # If no feet submitted then update param
          else 
              params["user"]["height_inches"] = params["user"]["height"]["inches"].to_i
          end

          # Delete height param since it will be saved as height_inches
          params["user"].delete "height"
        end

        # Check if user weight was submitted
        if params["user"]["weight"]

          # Check if user weight pounds was submitted
          if (params["user"]["weight"]["pounds"].to_i >= 1)

            # Convert pounds to ounces
            params["user"]["weight"]["pounds"] = params["user"]["weight"]["pounds"].to_i * 16
            
            # Add to ounces to get a total in ounces
            params["user"]["weight_ounces"] = params["user"]["weight"]["pounds"].to_i + params["user"]["weight"]["ounces"].to_i

          # If no feet submitted then update param
          else 
              params["user"]["weight_ounces"] = params["user"]["weight"]["ounces"].to_i
          end

          # Delete weight param since it will be saved as weight_ounces
          params["user"].delete "weight"
        end
      end
    end
end

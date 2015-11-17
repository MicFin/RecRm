class WelcomeController < Users::RegistrationsController
  include AppointmentsHelper
  include QualityReviewsHelper
  include PatientGroupsHelper
  include FamiliesHelper
	before_filter :check_user_logged_in!
  before_action :get_registration_stage, only: [:get_started, :add_family, :add_nutrition, :add_preferences, :set_appointment]

  # User dashboard
  # /welcome/home
  def home
    
    # if user is a provider then go to new user invitation page
    if current_user.provider?

      new_user_invitation_path

    else

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
      get_upcoming_appointments!
      @upcoming_appointments
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
      # Shows views/welcome/home.html.erb
    end
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
      # shouldnt need all 3
      get_upcoming_appointments!
      @upcoming_appointments
      @next_appointment
      # get_upcoming_appointments!
      # @upcoming_appointment
      get_previous_appointments!
      @previous_appointments
      
      # Get quota count
      # if @user.content_quotas.first != nil 
      #   @user.quality_review_quota_count = @user.content_quotas.first.quality_reviews
      # else
      #   @user.quality_review_quota_count = 0;
      # end

      # # Get completed quota count
      # @user.quality_review_quota_completed_count = @user.quality_reviews.where(:created_at => @beginning_of_week.beginning_of_day..@today.end_of_day, completed: true).count

      # # Get reviews that are not completed
      # get_incomplete_quality_reviews!
      # @incomplete_quality_reviews

      # Shows views/welcome/index.html.erb
    end

  end

  # Checks where user is in the registration process and directs them to the correct path
  # welcome/get_started
  def get_started
    
    
    @user = current_user

    # Stage 1 - user confirmed but did not complete account set up
    if @stage_of_registration == 1
      render :get_started

    # Stage 2 - user did not create family
    elsif @stage_of_registration == 2
      redirect_to welcome_add_family_path

    # Stage 3 - user created family but did not save health groups
    elsif @stage_of_registration == 3
      redirect_to welcome_add_nutrition_path

    # Stage 4 - user saved health groups but did not save diet
    elsif @stage_of_registration == 4
      redirect_to welcome_add_preferences_path

    # Stage 5 - user did not set up appointment
    elsif @stage_of_registration == 5
      redirect_to welcome_set_appointment_path

     # Done with registration, return to dashboard
    else
      redirect_to welcome_home_path
    end

  end

  # 2nd stage of registration
  # Select who the appointment is for and build other family member if necessary
  # /welcome/add_family
  def add_family

    if @stage_of_registration < 2
      redirect_to welcome_get_started_path
    end

    # Gather user's family data
    # from FamiliesHelper
    get_family!
    @family

    # New user for form
    @new_user = User.new(last_name: @user.last_name)
    
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
    
    # Get appointment
    appointment = @user.appointment_in_registration
    
    # If submitted user has a family role then it means the user created a family member or edited an old family member 
    if params[:user][:family_role]
      
      # If has an ID then they edited an old family member so update
      # Assign to appointment's patient focus
      if params[:user][:id]
        @family_member = User.find(params[:user][:id])
        @family_member.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
        appointment.patient_focus = @family_member

      # If no ID then a new user must be created
      # Create new family member and add roles
      # Assign to appointment's patient focus
      else
        @new_user = @family.users.create(devise_parameter_sanitizer.sanitize(:sign_up))
        @new_user.add_role "Family Member Account"
        @new_user.add_role "Family Member", @family
        @new_user.save
        appointment.patient_focus = @new_user
      end

    # If no family role was submitted then user selected self 
    # Update and assign to appointment's patient focus
    else
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      appointment.patient_focus = @user
    end

    # Save appointment with new patient focus
    appointment.save

    # Update the registration stage for the user
    update_stage(2, current_user)
  
    # Send to welcome#add_nutrition path to continue registration
    redirect_to welcome_add_nutrition_path

  end

  # 3rd stage of registration
  # Select add nutritional information to the user profile 
  # /welcome/add_nutrition
  def add_nutrition
    
    if @stage_of_registration < 3
      redirect_to welcome_get_started_path and return
    end

    # Reassign @user to the appointment's patient focus
    appointment = @user.appointment_in_registration
    @user = appointment.patient_focus

    # set current patient group ids for checkbox form
    @user.patient_group_ids = @user.get_patient_group_ids

    # Gather all major patient groups
    # Also gets user unverified groups
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

    # Reassign @user to the appointment's patient focus
    appointment = @user.appointment_in_registration
    @user = appointment.patient_focus
    
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
    
    # Update the registration stage for the user
    update_stage(3, current_user)

    # Send to welcome#add_preferences path to continue registration
    redirect_to welcome_add_preferences_path
  
  end

  # 4th stage of registration
  # Select add food preferences information to the user profile 
  # /welcome/add_preferences
  def add_preferences

    if @stage_of_registration < 4
      redirect_to welcome_get_started_path
    end

    # Reassign @user to the appointment's patient focus
    appointment = @user.appointment_in_registration
    @user = appointment.patient_focus
    
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

    # Reassign @user to the appointment's patient focus
    appointment = @user.appointment_in_registration
    @user = appointment.patient_focus

    # User may have submitted new health groups
    find_or_create_new_health_groups

    # Check if any data was submitted
    if params[:user]

      # Check if user has any diseases
      user_disease_ids = @user.get_nutrition_ids
      
      if user_disease_ids.count > 0  

        # Add disease IDs to the params so that they get included when it updates the users health groups 
        user_disease_ids.each {|id| params[:user][:patient_group_ids] << id}
      end

    end

    # Update without password
    # Do not want user entering password for each update during registration
    @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))

    # Update the registration stage for the user
    update_stage(4, current_user)

    # Send back to welcome#get_started to continue registration
    redirect_to welcome_get_started_path 

  end

  # 5th stage of registration
  # Select appointment time and checkout
  # /welcome/set_appointment
  def set_appointment
    if @stage_of_registration < 5
      redirect_to welcome_get_started_path
    end

    # get appointment
    @appointment = @user.appointment_in_registration
    
    # Get any appointment requests the user has made
    @appointment_requests = Appointment.where(appointment_host_id: current_user.id).where(status: "Requested").order('start_time ASC, created_at ASC')
    
    # Shows /welcome/set_appointment
  end


  private

    def get_registration_stage
      # set stage of registration to user's registration stage
      @stage_of_registration = @user.appointment_registration_stage
    end

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

    def update_stage(stage_complete, user)

      next_stage = stage_complete + 1

      # If repeat customer then update appointment in registration stage
      if user.repeat_customer? 
        current_appointment = user.appointment_in_registration

        if current_appointment.registration_stage < next_stage 
          current_appointment.registration_stage = next_stage
          current_appointment.save
        end

      # If not a repeat customer then update user registration stage
      else
        # Set registration status
        # Should add to function current_user.update_registration_stage
        if user.registration_stage < next_stage
          user.registration_stage = next_stage
          user.save
        end
      end
    end

end

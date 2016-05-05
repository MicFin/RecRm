class WelcomeController < Users::RegistrationsController
  include AppointmentsHelper
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

      # Gather user's previous appointments
      @previous_appointments = Appointments::AppointmentPresenter.present(current_user.appointment_hosts.previous.complete_or_scheduled.includes(:appointment_host).includes(:patient_focus).includes(:dietitian).by_start_time)

      # Gather user's upcoming appointment
      @upcoming_appointment = Appointments::AppointmentPresenter.new(current_user.appointment_hosts.upcoming_and_current.scheduled.first)

      # Gather user's upcoming appointments
      @upcoming_appointments = Appointments::AppointmentPresenter.present(current_user.appointment_hosts.upcoming_and_current.scheduled.includes(:appointment_host).includes(:patient_focus).by_start_time)

      # Gather user's umpaid appointment
      @unpaid_appointment = Appointments::AppointmentPresenter.new(current_user.appointment_hosts.where(status: "Follow Up Unpaid").last)

      @family = Families::FamilyPresenter.new(current_user.head_of_families.where(name: "Main").first)
    end
  end

  ### This is currently the dietitian's dashboard
  ### /welcome/index
  def index
    @upcoming_appointments = Appointments::AppointmentPresenter.present(current_dietitian.appointments.upcoming_and_current.includes(:appointment_host).includes(:patient_focus).by_start_time)
    @previous_appointments = Appointments::AppointmentPresenter.present(current_dietitian.appointments.previous.complete_or_scheduled.includes(:appointment_host).includes(:patient_focus).by_start_time)
  end

  # 1st stage of registration is for contact information
  # welcome/get_started
  def get_started
    
    @user = current_user
  end

  # # Would like to use another method than update
  # # Accepts form from welcome/get_started
  # # /welcome/update_client_info
  # # PATCH
  # def update_client_info
  # end


  # 2nd stage of registration
  # Select who the appointment is for and build other family member if necessary
  # /welcome/add_family
  def add_family
    if @stage_of_registration < 2
      redirect_to welcome_get_started_path
    end

    @family = Families::FamilyPresenter.new(current_user.head_of_families.find_or_create_by(name: "Main"))

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
    # @user.add_role "Head of Family", @family

    # Height and weight fields come in wrong format, need to clean for database.
    clean_height_and_weight_input
    
    # Get appointment
    appointment = @user.appointment_in_registration

    # If submitted user has a family role then it means the user created a family member or edited an old family member 
    if params[:user][:family_role]
      
      # If has an ID then they edited an old family member so update
      # Assign to appointment's patient focus
      if params[:id]
        @family_member = User.find(params[:id])
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
    # @user.patient_group_ids = @user.patient_group_ids

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
    redirect_to welcome_set_appointment_path 

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

    # if repeat customer then set previous dietitian 
    if @user.repeat_customer?

      previous_assigned_appt = @user.appointment_hosts.scheduled.where.not(dietitian_id: nil).last

      if previous_assigned_appt 
        @previous_dietitian = previous_assigned_appt.dietitian
      else
        @previous_dietitian = Dietitian.where(email: "mrfinneran+rd@gmail.com").first
        # @previous_dietitian = Dietitian.where(email: "tara@kindrdfood.com")
      end
    end
    
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

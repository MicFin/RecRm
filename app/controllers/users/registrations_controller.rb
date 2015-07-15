# http://stackoverflow.com/questions/16379554/strong-parameters-with-rails-4-0-and-devise
class Users::RegistrationsController < Devise::RegistrationsController
  include PatientGroupsHelper
  before_filter :configure_permitted_parameters, :except => [:new_user_intro, :new_user_family] 

  # POST /resource
  def create
    
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource

      # should check if QOL sign up or not then redirect or change flash alert
      # set flash error messages
      resource.errors.full_messages.each {|x| flash[:error] = x}
      # override devise default to go to last location
      redirect_to request.referrer
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    
    sign_in(resource_name, resource)
  end

  def after_sign_up_path_for(resource)
      
    after_sign_in_path_for(resource)
  end

  # Users that require confirmation, currently from QOL landing page
  # only QOL admin should be creating these so can redirect to qol
  def after_inactive_sign_up_path_for(resource)
    
    # override confirmation sent flash notice for QOLadmin
    flash[:notice] = 'Client was successfully added.'
    landing_pages_qol_admin_path
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

#new user intro to the form where they update their name and select self or other user for appointment then
# update to new_user_family
  # def new_user_intro
    
  #   @user = current_user || User.find(params[:id])
  #   @sign_up_stage = @user.sign_up_stage
     
  #   if @sign_up_stage == 2
  #     redirect_to new_user_family_path(@user)
  #   elsif @sign_up_stage == 3
  #     redirect_to select_time_path(@user.appointment_hosts.last)
  #   else
      
  #     # render :new_user_intro and return
  #   end
  #   respond_to do |format|

  #       # # need to redirect somwhere........
  #       # format.js 
  #       format.html
  #   end
  # end

# hopefully dont need any of this
  # def new_user_family
    
  #   @user = User.find(params[:id])
  #   @sign_up_stage = @user.sign_up_stage 
  #   @family = @user.head_of_families.last
  #   @appointment = Appointment.where(appointment_host_id: @user.id).where(status: "In Registration").last
  #   # if params[:client_first_name]
  #   # should create method on family model
  #   # this gets family members with patient focus first
  #   @family_members = []
    
  #   if @appointment.patient_focus 
  #     appointment_focus = @appointment.patient_focus
  #     @family_members << appointment_focus
  #   end
  #   family_count = @family.users.count
    
  #   if family_count > 0

  #     if @user != appointment_focus
  
  #       @family_members << @user
  #       @family.users.each do |family_member| 
  #         if family_member != appointment_focus
      
  #           @family_members << family_member 
  #         end
  #       end
  #     else
  
  #       @family.users.each do |family_member|
  #           @family_members << family_member
  #       end
  #     end
  #   else

  #     @family_members << @user
  #   end
  #   get_patient_groups!
  #   @diseases = @diseases 
  #   @intolerances = @intolerances 
  #   @patient_groups = @patient_groups
  #   @allergies = @allergies_with_other
  #   @diets =  @diets
  #   @patient_groups 
    

  #   # respond_to do |format|
  #   #   format.js
  #   #   format.html
  #   # end
    
  # end

  # def new_family_member
    
  #     @user = current_user
  #     @family = @user.head_of_families.last
  #     @family.users.build
  #     @new_user = User.new(last_name: @user.last_name)
  #     @appointment = @user.appointment_hosts.last
  #     get_patient_groups!
  #     @diseases = @diseases 
  #     @intolerances = @intolerances 
  #     @allergies = @allergies
  #     @diets =  @diets 
  #     respond_to do |format|
  #       format.js
  #       # format.html
  #     end
  # end

  # def create_family_member
    
  #   @user = current_user
  #   if params["new_health_groups"]
  #     params["new_health_groups"].each do |health_group|
  #        group = PatientGroup.new(name: health_group, unverified: true) 
  #        group.save
  #        params["user"]["patient_group_ids"].push(group.id)
  #     end
  #   end
  #   @new_user = User.create(devise_parameter_sanitizer.sanitize(:sign_up))
  #   respond_to do |format|
  #     if @new_user.save
  #       @family = @user.head_of_families.last
  #       @family.users << @new_user
  #       @family.save
  #       @appointment = @user.appointment_hosts.last
  #       # should create method on family model
  #       # this gets family members with patient focus first
  #       @family_members = []
    
  #       if @appointment.patient_focus 
  #         appointment_focus = @appointment.patient_focus
  #         @family_members << appointment_focus
  #       end
  #       family_count = @family.users.count
  #       if family_count > 0
    
  #         if @user != appointment_focus
      
  #           @family_members << @user
  #           @family.users.each do |family_member| 
  #             if family_member != appointment_focus
          
  #               @family_members << family_member 
  #             end
  #           end
  #         else
  #           @family.users.each do |family_member|
  #               @family_members << family_member
  #           end
  #         end
  #       else
  #         @family_members << @user
  #       end
  #       # need to redirect somwhere........
  #       format.html { redirect_to @allergens_ingredient, notice: 'allergens_ingredient was successfully created.' }
  #       format.json { render :show, status: :created, location: @allergens_ingredient }
  #       # we are responding to JS right now, create.js.erb
  #       format.js { render "update_user_health_groups"}
  #     else
  #       format.html { render :new }
  #       format.json { render json: @allergens_ingredient.errors, status: :unprocessable_entity }
  #     end
  #   end     
  # end


  # def edit_user_health_groups
    
  #   @user = current_user
  #   @family = @user.head_of_families.last
  #   @updated_user_id = params[:id]
  #   @updated_user = User.find(@updated_user_id)
  #   get_patient_groups!
  #   @diseases = @diseases 
  #   @intolerances = @intolerances 
  #   @allergies = @allergies
  #   @diets =  @diets  
    
  #   @unverified_health_groups = @updated_user.unverified_health_groups
  #   respond_to do |format|
  #       # # need to redirect somwhere........
  #       # # we are responding to JS right now, create.js.erb
  #       format.js 
  #   end
  # end


  # def update_user_health_groups
  #   if params["new_health_groups"]
  #     params["new_health_groups"].each do |health_group|
  #        group = PatientGroup.new(name: health_group, unverified: true) 
  #        group.save
  #        params["user"]["patient_group_ids"].push(group.id)
  #     end
  #   end    
  #   @updated_user = User.find(params[:updated_user_id])
  #   @updated_user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
  #   @updated_user.save
    
  #   @user = current_user
  #   @family = @user.head_of_families.last
  #   @appointment = @user.appointment_hosts.last
  #   @family_members = []
  #   if @appointment.patient_focus 
  #     appointment_focus = @appointment.patient_focus
  #     @family_members << appointment_focus
  #   end
  #   family_count = @family.users.count
    
  #   if family_count > 0

  #     if @user != appointment_focus
  
  #       @family_members << @user
  #       @family.users.each do |family_member| 
  #         if family_member != appointment_focus
      
  #           @family_members << family_member 
  #         end
  #       end
  #     else
  
  #       @family.users.each do |family_member|
  #           @family_members << family_member
  #       end
  #     end
  #   else

  #     @family_members << @user
  #   end
  #   # for in-session update JS response
  #   get_patient_groups!
  #   @diseases = @diseases 
  #   @intolerances = @intolerances 
  #   @allergies = @allergies
  #   @diets =  @diets  
  #   redirect_to select_time_path(@appointment)
  # end

  def update
    
    @user = current_user
    # check if a password is needed for this update
    successfully_updated = if needs_password?(@user, params)
      # if password is needed
      # then update with password
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      
    else
      
      # if no password is needed 
      # remove the virtual current_password attribute
      params[:user].delete(:current_password)
      # update_without_password doesn't know how to ignore it
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated

      # update user registration stage
      @user.update_registration_stage

      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      
      sign_in @user, :bypass => true
      
      after_update_path_for(@user)
    else
      render "edit"
    end
  end







  protected

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
      params[:user][:email].present? ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  # def clean_params(params)
  #   
    # if params["user"]
    #   if params["user"]["height"]
    #     if (params["user"]["height"]["feet"].to_i >= 1)
    #             params["user"]["height"]["feet"] = params["user"]["height"]["feet"].to_i * 12
    #             params["user"]["height_inches"] = params["user"]["height"]["feet"].to_i + params["user"]["height"]["inches"].to_i
    #     else 
    #         params["user"]["height_inches"] = params["user"]["height"]["inches"].to_i
    #     end
    #     params["user"].delete "height"
    #   end
    #   if params["user"]["weight_ounces"]
    #     params["user"]["weight_ounces"] = params["user"]["weight_ounces"].to_i * 16
    #   end
  #   return params
  # end
  def after_update_path_for(resource)
        
      # if they have finished on boarding
      if resource.finished_on_boarding? 
          
      else
        redirect_to welcome_get_started_path
      end
        # respond_to do |format|
        #   format.js { render "/users/registrations/update.js.erb" and return }
        #   # format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        #   # format.json { render :show, status: :created, location: @appointment }
        # end 
      #   else
      #     ### OLD: what to do if they go back and create another user or remove the user that was the focus
      #     return new_family_path
      #   end
      # else
        
        ##### this is where the orginal family is made
        ##### registrations/new_user_intro/# assigns appointment here
        # @user = resource
        # @family = Family.new(name: "Main Family", head_of_family_id: @user.id)
        # @family.save
        # @user.add_role "Head of Family", @family
        # if params["appoint_self"] == "true"
        #   @appointment = Appointment.new(appointment_host_id: @user.id, patient_focus_id: @user.id, status: "In Registration")
        # else
        #   @new_user = User.new(first_name: params[:client_first_name], last_name: params[:client_last_name])
        #   @new_user.add_role "Family Member Account"
        #   @new_user.add_role "Family Member", @family
        #   @new_user.save
        #   @family.users << @new_user
        #   @family.save
        #   @appointment = Appointment.new(appointment_host_id: @user.id, patient_focus_id: @new_user.id, status: "In Registration")
        # end
        # @appointment.save
        # # if non main user
        # # else main users
        # return new_user_family_path(@user)
      # end
  end

  private


  # my custom fields are :name, :heard_how
  def configure_permitted_parameters
    
    devise_parameter_sanitizer.for(:sign_up) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :family_note, :family_role, :early_access, :tara_referral, :zip_code, :phone_number, :qol_referral, :registration_stage, :due_date, :patient_group_ids => [])
    end
    devise_parameter_sanitizer.for(:account_update) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :stripe_id, :family_note, :family_role, :early_access, :zip_code, :phone_number, :qol_referral, :registration_stage, :due_date, :patient_group_ids => [])
    end
  end
  
end
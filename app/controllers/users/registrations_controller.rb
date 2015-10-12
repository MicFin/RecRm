# http://stackoverflow.com/questions/16379554/strong-parameters-with-rails-4-0-and-devise
class Users::RegistrationsController < Devise::RegistrationsController
  include PatientGroupsHelper
  before_filter :configure_permitted_parameters, :except => [:new_user_intro, :new_user_family] 

  # GET /resource/sign_up
  def new
    build_resource({})
  
    # custom devise respond to js or html
    respond_to do |format|
      format.js 
      format.html{
        respond_with self.resource
      }
    end
  end


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
    
    # if physician or qol admin paths
    # override confirmation sent flash notice for QOLadmin
    flash[:notice] = 'Kindrdfood invitation was successfully sent.'

    if resource.qol_referral == true 
      landing_pages_qol_admin_path
    else
      landing_pages_refer_path
    end
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

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

  def update_time_zone

    # update the user's time zone
    @user = current_user
    @user.update_attribute(:time_zone, params[:user][:time_zone])

    # get original page where time zone was updated from
    session[:return_to] ||= request.referer

    respond_to do |format|

      # update_time_zone.js replace calendar with new events based on updated time zone
      format.js

      # redirect back to original page where time zone was updated
      format.html { redirect_to session.delete(:return_to) }
    end
  end

  protected

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
      # params[:user][:email].present? ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  def after_update_path_for(resource)
        
      # if they have not finished on boarding
      if !resource.finished_on_boarding? 
      
        redirect_to welcome_get_started_path
      end

  end

  private



  def configure_permitted_parameters
    
    devise_parameter_sanitizer.for(:sign_up) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :family_note, :family_role, :early_access, :tara_referral, :zip_code, :phone_number, :qol_referral, :physician_referral, :registration_stage, :due_date, :time_zone, :provider, :hospitals_or_practices, :academic_affiliations, :academic_affiliations, :subspecialty, :fax, :terms_accepted, :patient_group_ids => [])
    end

    # might want tot remove qol_referral from permitted params for update
    devise_parameter_sanitizer.for(:account_update) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :stripe_id, :family_note, :family_role, :early_access, :zip_code, :phone_number, :qol_referral, :physician_referral, :registration_stage, :due_date, :time_zone, :provider, :hospitals_or_practices, :academic_affiliations, :academic_affiliations, :subspecialty, :fax, :terms_accepted, :patient_group_ids => [])
    end


    # # USE THESE WHEN DOING CONFIRMATION
    # # To be continued ...
    # devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :phone]

    # # USE THESE WHEN DOING CONFIRMATION
    # # To be continued ...
    # devise_parameter_sanitizer.for(:accept_invitation) do |u|
    #   u.permit(:first_name, :last_name, :phone, :password, :password_confirmation, :invitation_token)
    # end
  end
  
end
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

  def create_family_member
    
    family = current_user.head_of_families.last
    find_or_create_new_health_groups

    clean_height_and_weight_input
    @family_member = family.users.create(devise_parameter_sanitizer.sanitize(:sign_up))
    @family_member.add_role "Family Member Account"
    @family_member.add_role "Family Member", family
    
    if @family_member.save
      redirect_to family_path(family)
    else
      render "/families/new_family_member"
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

    # user updating a fmaily member
    if params[:family_member] == "true"
      @family_member = User.find(params[:user][:id])

      find_or_create_new_health_groups

      clean_height_and_weight_input
      
      successfully_updated = @family_member.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      
      if successfully_updated

        set_flash_message :notice, :updated

        if @family_member.families != [] 
          
          family = @family_member.families.last 

        else 
          family = @family_member.head_of_families.last 
        end

        redirect_to family_path(family)
      else
        render "/families/edit_family_member"
      end

    else
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
  end

  # def update_family_member
    
    
  #   @user = current_user
  #   # check if a password is needed for this update
  #   successfully_updated = if needs_password?(@user, params)
  #     # if password is needed
  #     # then update with password
  #     @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      
  #   else
      
  #     # if no password is needed 
  #     # remove the virtual current_password attribute
  #     params[:user].delete(:current_password)
  #     # update_without_password doesn't know how to ignore it
  #     @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
  #   end
    
    
  #   if successfully_updated

  #     # update user registration stage
  #     @user.update_registration_stage

  #     set_flash_message :notice, :updated
  #     # Sign in the user bypassing validation in case their password changed
      
  #     sign_in @user, :bypass => true
      
  #     after_update_path_for(@user)
  #   else
  #     render "edit"
  #   end
  # end

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


    # If a user submits new health groups then check if they are in our database or create them and prepare them to be saved
    def find_or_create_new_health_groups
      
      # Check if user input was submitted
      if params["user"]

        # Check if health new health groups were submitted
        if params["new_health_groups"]
    
          #  Find or create new health groups and add them to the params to be saved
          params["new_health_groups"].each do |group_type, health_groups|
            health_groups.each do |health_group|
              group = PatientGroup.find_or_create_by(name: health_group, unverified: true, category: group_type, order: 10000) 
              group.save
              params["user"]["patient_group_ids"].push(group.id)
            end 
          end
    
          # Delete the new health groups param
          params.delete "new_health_groups"
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



  private



  def configure_permitted_parameters
    
    devise_parameter_sanitizer.for(:sign_up) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :family_note, :family_role, :early_access, :tara_referral, :zip_code, :phone_number, :qol_referral, :physician_referral, :registration_stage, :due_date, :time_zone, :provider, :hospitals_or_practices, :academic_affiliations, :academic_affiliations, :subspecialty, :fax, :terms_accepted, :remove_image, :images_attributes => [:image_type, :imageable_id, :imageable_type, :position, :image_cache, :crop_x, :crop_y, :crop_w, :crop_h, :crop_image, :remove_image, :image], :patient_group_ids => [])
    end

    # might want tot remove qol_referral from permitted params for update
    devise_parameter_sanitizer.for(:account_update) do |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :weight_ounces, :height_inches, :sex, :stripe_id, :family_note, :family_role, :early_access, :zip_code, :phone_number, :qol_referral, :physician_referral, :registration_stage, :due_date, :time_zone, :provider, :hospitals_or_practices, :academic_affiliations, :academic_affiliations, :subspecialty, :fax, :terms_accepted, :remove_image, :images_attributes => [:image_type, :imageable_id, :imageable_type, :position, :image_cache, :crop_x, :crop_y, :crop_w, :crop_h, :crop_image, :remove_image, :image], :patient_group_ids => [])
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
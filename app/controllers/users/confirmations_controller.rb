
class Users::ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user!

  # PUT /resource/confirmation
  def update
    
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid? and @confirmable.password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      # this view has not been styled
      render 'devise/confirmations/new' #Change this if you don't have the views on default path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    
    
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path 
    end
  end


  protected

  def with_unconfirmed_confirmable
    
    
    original_token = params[:confirmation_token]
    confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    
    
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    render 'users/confirmations/show' #Change this if you don't have the views on default path
  end

  def do_confirm
    

    @confirmable.confirm!

    # update registration stage to 1 since confirmed
    @confirmable.update_registration_stage

    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
    
    # after_confirmation_path_for(@confirmable.class, @confirmable)
  end

  private

  # def after_confirmation_path_for(resource_name, resource)
  #   
  #   your_new_after_confirmation_path
  # end
      # The path used after confirmation.
#     def after_confirmation_path_for(resource_name, resource)
# 
#         # remove the virtual current_password attribute
#         params[:user].delete(:password)
#         params[:user].delete(:password_confirmation)
#         # update_without_password doesn't know how to ignore it
#         resource.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
#         # Sign in the user by passing validation in case their password changed
#         sign_in resource, :bypass => true
#         
#         redirect_to welcome_get_started_path(resource)

#     end
end
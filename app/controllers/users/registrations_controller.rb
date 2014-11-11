# http://stackoverflow.com/questions/16379554/strong-parameters-with-rails-4-0-and-devise
class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, :except => [:new_user_intro, :new_user_family] 
  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)

    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)

    after_sign_in_path_for(resource)
  end

  def sign_up_params

    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def new_user_intro
    @user = User.find(params[:id])
    
  end

  def new_user_family
    binding.pry
    @user = User.find(params[:id])
    @family = Family.new
    @family.users.build
    @new_user = User.new(last_name: @user.last_name)
    # respond_to do |format|
    #   format.js
    #   format.html
    # end
  end

  # # PUT /resource
  # # We need to use a copy of the resource because we don't want to change
  # # the current user in place.
  # def update
  #   
  #   self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #   prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  #   resource_updated = update_resource(resource, account_update_params)
  #   yield resource if block_given?
  #   if resource_updated
  #     if is_flashing_format?
  #       flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
  #         :update_needs_confirmation : :updated
  #       set_flash_message :notice, flash_key
  #     end
  #     sign_in resource_name, resource, bypass: true
  #     respond_with resource, location: after_update_path_for(resource)
  #   else
  #     clean_up_passwords resource
  #     respond_with resource
  #   end
  #   
  # end

  def update
    
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      
    else
      
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
      params[:user][:email].present? ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  protected

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation, :current_password)
    end
  end

    def after_update_path_for(resource)
      binding.pry
      # if new user
      # if non main user
      # else main users
      return new_user_family_path(resource)
    end

end
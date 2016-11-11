class Users::InvitationsController < Devise::InvitationsController
  # def update
  #   if this
  #     redirect_to root_path
  #   else
  #     super
  #   end
  # end
  def index
    @invitations_not_accepted = User.invitation_not_accepted
    @invitations_accepted = User.invitation_accepted 
  end

  # def after_accept_path_for
  # end

    # GET /resource/invitation/new
  def new
    self.resource = resource_class.new
    @invitees = current_user.invitations
    render :new
  end


  # POST /resource/invitation
  def create

    self.resource = invite_resource

    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
  
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      respond_with resource, :location => after_invite_path_for(current_inviter)
    else
  
      respond_with_navigational(resource) { render :new }
    end
  end

 private

  # def resource_params
  #   params.permit(user: [:first_name, :last_name, :email_address, :invitation_token])[:user]
  # end

  # # this is called when creating invitation
  # # should return an instance of resource class
  # def invite_resource
  #   ## skip sending emails on invite
  #   resource_class.invite!(invite_params, current_inviter) do |u|
  #     u.skip_invitation = true
  #   end
  # end

  # # this is called when accepting invitation
  # # should return an instance of resource class
  # def accept_resource
  #   resource = resource_class.accept_invitation!(update_resource_params)
  #   ## Report accepting invitation to analytics
  #   Analytics.report('invite.accept', resource.id)
  #   resource
  # end

# # Only add some parameters
#   devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name, :phone]

#   # Override accepted parameters
#   devise_parameter_sanitizer.for(:accept_invitation) do |u|
#     u.permit(:first_name, :last_name, :phone, :password, :password_confirmation, :invitation_token)
#   end

  # def authenticate_inviter!
  #   authenticate_admin!(:force => true)
  # end
end
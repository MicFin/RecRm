class Users::SessionsController < Devise::SessionsController


   # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    # custom devise respond to js or html
    respond_to do |format|

      format.js 
      format.html{
        respond_with(resource, serialize_options(resource))
      }
    end
  end



end

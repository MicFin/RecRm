# All Administrate controllers inherit from this `ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
class Admin::ApplicationController < Administrate::ApplicationController
  before_filter :authenticate_admin

  def authenticate_admin
    redirect_to '/', alert: 'Not authorized.' unless current_dietitian && (current_dietitian.has_role? "Admin Dietitian")
  end
end

class LandingPagesController < ApplicationController

  # home page
  def index
  end

  #
  def qol_admin
    @user = User.new 
  end
end

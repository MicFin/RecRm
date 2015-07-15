class LandingPagesController < ApplicationController

  # home page
  def index
    @user = User.new 
  end

  # qol admin home page
  def qol_admin
  
    @user = User.new 
  end
end

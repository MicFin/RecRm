class LandingPagesController < ApplicationController

  # home page
  def index
  end

  #
  def qol_admin
    binding.pry
    @user = User.new 
  end
end

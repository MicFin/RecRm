class LandingPagesController < ApplicationController

  # home page
  def index
  end

  #
  def qol
    @user = User.new 
  end
end

class LandingPagesController < ApplicationController

  # home landing page
  def index
    @user = User.new 
  end

  # qol admin landing page
  def qol_admin
    @user = User.new 
  end

# qol direct sign up landing page
  def qol
    @user = User.new 
  end

# tara referral landing page
  def tara
    @user = User.new 
  end

# /join redirects to /tara referral landing page
  # def join
  #   @user = User.new 
  # end

end

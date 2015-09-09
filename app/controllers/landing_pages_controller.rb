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

  def our_solution
  end

  def results
  end

  def how_it_works
  end

  def who_we_help
  end

  def why_kindrdfood
  end

  def quality
  end

  def navigate_change
  end

  def our_mission
  end

  def leaders
  end

  def benefits
  end

  def more_benefits
  end

  def care
  end

  def refer
  end

end

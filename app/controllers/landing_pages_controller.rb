class LandingPagesController < ApplicationController
  before_action :set_new_user

  # qol admin landing page
  def qol_admin
  end

  # qol direct sign up landing page
  def qol
  end

  # tara referral landing page
  def tara
  end

  # Original landing pages
  def index
  end
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
  def leadership
  end
  def benefits
  end
  def more_benefits
  end
  def care
  end
  def contact_us
  end
  def refer
  end

  # new landing pages
  def new_landing_page
  end

  def new_provider_page
  end

  def new_contact_us_page
  end

  def new_leadership_page
  end

  def new_faq_page
  end

  def new_sign_up_page
  end

  def new_sign_in_page
  end

  private

    def set_new_user
      @user = User.new 
    end
end

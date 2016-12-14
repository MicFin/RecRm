class DietitianMailer < ActionMailer::Base
  default :from => "admin@kindrdfood.com"

  def appointment_confirmation(dietitian)
    @dietitian = dietitian
    mail(:to => @dietitian.email, :subject => "Welcome to Kindrdfood!")
  end


end
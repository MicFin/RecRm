class DietitianMailer < ActionMailer::Base
  default :from => "admin@kindrdfood.com"

  def new_appointment(dietitian_id)
    @dietitian = Dietitian.find(dietitian_id)
    mail(:to => @dietitian.email, :subject => "Welcome to Kindrdfood!")
  end


end
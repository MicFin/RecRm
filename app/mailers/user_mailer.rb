class UserMailer < ActionMailer::Base
  default :from => "admin@kindrdfood.com"

  def welcome_message(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end
end
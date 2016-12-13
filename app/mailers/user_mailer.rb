class UserMailer < ActionMailer::Base
  default :from => "admin@kindrdfood.com"

  def registration_confirmation(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def registration_one_day_reminder(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def registration_one_week_reminder(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def new_appointment(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_3_day(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_1_day(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_1_hour(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_late_5_minutes(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_missed(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def assessment_ready(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

end
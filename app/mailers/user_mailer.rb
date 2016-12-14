class UserMailer < ActionMailer::Base
  default :from => "admin@kindrdfood.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def registration_reminder_1_day(user)
    @user = user
    if @user.registration_stage < 6 
      mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
    end
  end

  def registration_reminder_1_week(user)
    @user = user
    if @user.registration_stage < 6 
      mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
    end
  end

  def appointment_confirmation(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_3_day(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_1_day(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_reminder_1_hour(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_late_5_minutes(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_missed(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

  def appointment_assessment_ready(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Kindrdfood!")
  end

end